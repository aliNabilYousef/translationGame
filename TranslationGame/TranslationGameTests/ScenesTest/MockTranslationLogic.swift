//
//  MockTranslationLogic.swift
//  TranslationGame
//
//  Created by Ali Youssef on 02/07/2022.
//

import Foundation
@testable import TranslationGame

class MockTranslationLogic: LogicProtocol {
    
    var didTriggerIsRight = false
    var didGetGameData = false
    var didGetNextLevel = false
    var didResetGameData = false
    
    func isRight(level: LevelProtocol) -> Bool {
        didTriggerIsRight = true
        return true
    }
    
    func getGameData() {
        didGetGameData = true
    }
    
    func getNextLevel() -> LevelProtocol {
        didGetNextLevel = true
        return TranslationLevel(question: "", options: [])
    }
    
    func resetGameData() {
        didResetGameData = true
    }

}
