//
//  GameViewModel.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GameViewModelProtocol {
    var game: GameProtocol? { get set }
    var correctCounter: BehaviorRelay<Int> { get set }
    var wrongCounter: BehaviorRelay<Int> { get set }
    var firstWord: BehaviorRelay<String> { get set }
    var secondWord: BehaviorRelay<String> { get set }
    var answers: BehaviorRelay<[String]> { get set }
    var previousAnswerState: BehaviorRelay<Bool> { get set }
    var countDownValue: BehaviorRelay<Int> { get set }
    func selectAnswer(index: Int)
}

class GameViewModel: GameViewModelProtocol {
    
    //MARK: Protocol variables
    var game: GameProtocol?
    var correctCounter: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var wrongCounter: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var firstWord: BehaviorRelay<String> = BehaviorRelay(value: "")
    var secondWord: BehaviorRelay<String> = BehaviorRelay(value: "")
    var answers: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    var previousAnswerState: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    var countDownValue: BehaviorRelay<Int>
    
    //MARK: Class variables
    private(set) var currentLevel = BehaviorRelay<LevelProtocol?>(value: nil)
    private let disposeBag = DisposeBag()
    private var timer: Timer!
    private var countDownTimer: Timer!
    
    init(with game: GameProtocol?) {
        self.game = game
        countDownValue = BehaviorRelay(value: Int(game?.timeInterval ?? 5))
        
        game?.numberOfCorrect.bind(to: correctCounter).disposed(by: disposeBag)
        game?.numberOfWrong.bind(to: wrongCounter).disposed(by: disposeBag)
        
        currentLevel.asDriver().skip(1).drive {[unowned self] level in
            firstWord.accept(level?.question ?? "")
            secondWord.accept(level?.options.first ?? "")
            answers.accept(level?.answers ?? [])
            setTimer()
        }.disposed(by: disposeBag)
        
        wrongCounter.asDriver().drive {[unowned self] wrongCtr in
            if wrongCtr >= 3 {
                self.gameOver()
            }
        }.disposed(by: disposeBag)
        
        correctCounter.asDriver().drive {[unowned self] correctCtr in
            if correctCtr >= 15 {
                self.gameOver()
            }
        }.disposed(by: disposeBag)
        
        game?.currentLevel.bind(to: currentLevel).disposed(by: disposeBag)
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: game?.timeInterval ?? 5, target: self, selector: #selector(timedOut), userInfo: nil, repeats: true)
        countDownValue.accept(Int(game?.timeInterval ?? 5))
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimerDecrement) , userInfo: nil, repeats: true)
    }
    
    //MARK: logic functions
    func selectAnswer(index: Int) {
        guard var level = currentLevel.value else { return }
        timer.invalidate()
        countDownTimer.invalidate()
        level.selectAnswer(number: index)
        previousAnswerState.accept(game?.verifyLevel(with: level) ?? false)
    }
    
    @objc private func timedOut() {
        guard let level = currentLevel.value else { return }
        timer.invalidate()
        countDownTimer.invalidate()
        previousAnswerState.accept(game?.verifyLevel(with: level) ?? false)
    }
    
    @objc private func countDownTimerDecrement() {
        let countDownValue = countDownValue.value
        self.countDownValue.accept(countDownValue - 1)
    }
    
    func gameOver() {
        timer.invalidate()
        countDownTimer.invalidate()
        game?.gameOver()
    }
}
