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
    var numberOfCorrect: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    var numberOfWrong: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    
    init(translationLogic: LogicProtocol) {
        self.gameLogic = translationLogic
        gameLogic?.getGameData()
    }
    
    func resetGame() {
        numberOfCorrect.accept(0)
        numberOfWrong.accept(0)
        gameLogic?.resetGameData()
    }
    
    func getNextLevel() -> LevelProtocol {
        guard let gameLogic = gameLogic else { fatalError() } //should be handled differently
        return gameLogic.getNextLevel()
    }
    
    func verifyLevel(with level: LevelProtocol) {
        let verification: Bool = gameLogic?.isRight(level: level) ?? false
        let correctCounter = numberOfCorrect.value
        let incorrectCounter = numberOfWrong.value
        
        if verification {
            numberOfCorrect.accept(correctCounter + 1)
        } else {
            numberOfWrong.accept(incorrectCounter + 1)
        }
    }
    
    func gameOver() {
        //kill the app
        fatalError()
    }
    
}
