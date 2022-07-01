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
    func getNextLevel()
    func selectAnswer(index: Int)
}

class GameViewModel: GameViewModelProtocol {
    
    //MARK: Protocol variables
    var game: GameProtocol?
    var correctCounter: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var wrongCounter: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var firstWord: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var secondWord: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var answers: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    
    //MARK: Class variables
    private var currentLevel = BehaviorRelay<LevelProtocol?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(with game: GameProtocol?) {
        self.game = game
        
        game?.numberOfCorrect.bind(to: correctCounter).disposed(by: disposeBag)
        game?.numberOfWrong.bind(to: wrongCounter).disposed(by: disposeBag)
        
        currentLevel.asDriver().drive {[unowned self] level in
            firstWord.accept(level?.question ?? "")
            secondWord.accept(level?.options.first ?? "")
            answers.accept(level?.answers ?? [])
        }.disposed(by: disposeBag)
        
        getNextLevel()
    }
    
    //MARK: logic functions
    func getNextLevel() {
        currentLevel.accept(game?.getNextLevel())
    }
    
    func selectAnswer(index: Int) {
        guard var level = currentLevel.value else { return }
        level.selectAnswer(number: index)
        game?.verifyLevel(with: level)
        getNextLevel()
    }
}
