//
//  TranslationGame.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class TranslationGame: GameProtocol {
    
    var gameLogic: LogicProtocol?
    var numberOfCorrect: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var numberOfWrong: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var timeInterval: Double
    var currentLevel: BehaviorRelay<LevelProtocol?> = BehaviorRelay(value: nil)
    private var shouldGetNextLevel: Bool = true
    
    init(translationLogic: LogicProtocol) {
        self.gameLogic = translationLogic
        timeInterval = 5
        gameLogic?.getGameData()
        getNextLevel()
    }
    
    func resetGame() {
        numberOfCorrect.accept(0)
        numberOfWrong.accept(0)
        gameLogic?.resetGameData()
        shouldGetNextLevel = true
        currentLevel.accept(gameLogic?.getNextLevel())
    }
    
    func getNextLevel() {
        guard let gameLogic = gameLogic, shouldGetNextLevel else { return }
        currentLevel.accept(gameLogic.getNextLevel())
    }
    
    func verifyLevel(with level: LevelProtocol) -> Bool {
        let verification: Bool = gameLogic?.isRight(level: level) ?? false
        let correctCounter = numberOfCorrect.value
        let incorrectCounter = numberOfWrong.value
        
        if verification {
            numberOfCorrect.accept(correctCounter + 1)
        } else {
            numberOfWrong.accept(incorrectCounter + 1)
        }
        getNextLevel()
        return verification
    }
    
    func gameOver() {
        //kill the app
        shouldGetNextLevel = false
        let didSucceed = numberOfWrong.value < 3
        Application.shared.showFinishAlert(title: didSucceed ? "good job".localized : "game over".localized,
                                           message: didSucceed ? "success message".localized : "failed message".localized,
                                           onReset: {[weak self] _ in
                                                        self?.resetGame()
                                                    },
                                           onQuit: { _ in 
                                                        exit(0)
                                                    })
    }
    
}
