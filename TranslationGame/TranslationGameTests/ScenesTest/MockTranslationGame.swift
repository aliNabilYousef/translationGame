//
//  MockTranslationGame.swift
//  TranslationGame
//
//  Created by Ali Youssef on 02/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

@testable import TranslationGame

class MockTranslationGame: GameProtocol {
    
    var gameLogic: LogicProtocol?
    var numberOfCorrect: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var numberOfWrong: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var timeInterval: Double
    var currentLevel: BehaviorRelay<LevelProtocol?> = BehaviorRelay(value: nil)
    
    var didReset = false
    var didVerify = false
    var didGetNextLevel = false
    var didTriggerGameOver = false
    
    init(translationLogic: LogicProtocol) {
        self.gameLogic = translationLogic
        timeInterval = 5
        gameLogic?.getGameData()
        getNextLevel()
    }
    
    func resetGame() {
        didReset = true
    }
    
    func verifyLevel(with level: LevelProtocol) -> Bool {
        didVerify = true
        let _ = gameLogic?.isRight(level: level)
        return true
    }
    
    func getNextLevel() {
       didGetNextLevel = true
    }
    
    func gameOver() {
        didTriggerGameOver = true
    }
    
}
