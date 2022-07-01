//
//  TranslationGameTests.swift
//  TranslationGameTests
//
//  Created by Ali Youssef on 01/07/2022.
//

import XCTest
@testable import TranslationGame

class TranslationGameTests: XCTestCase {
    let translationGame = TranslationGame(translationLogic: TranslationLogic())
    
    let correctTranslationEnglish = "(to) paint"
    let correctTranslationSpanish = "pintar"
    let wrongTranslationSpanish = "sentirse"
    
    func test_verify_level() {
        XCTAssertEqual(translationGame.numberOfCorrect.value, 0)
        XCTAssertEqual(translationGame.numberOfIncorrect.value, 0)
        
        //testing correct incrementation
        var level = TranslationLevel(question: correctTranslationEnglish, options: [correctTranslationSpanish])
        level.selectAnswer(number: 0)
        translationGame.verifyLevel(with: level)
        XCTAssertEqual(translationGame.numberOfCorrect.value, 1)
        
        //testing incorrect incrementation
        var level1 = TranslationLevel(question: correctTranslationEnglish, options: [correctTranslationSpanish])
        level1.selectAnswer(number: 1)
        translationGame.verifyLevel(with: level1)
        XCTAssertEqual(translationGame.numberOfIncorrect.value, 1)
    }
    
    func test_reset_game() {
        XCTAssertEqual(translationGame.numberOfCorrect.value, 0)
        XCTAssertEqual(translationGame.numberOfIncorrect.value, 0)
        
        translationGame.numberOfCorrect.accept(1)
        translationGame.numberOfIncorrect.accept(1)
        
        XCTAssertEqual(translationGame.numberOfCorrect.value, 1)
        XCTAssertEqual(translationGame.numberOfIncorrect.value, 1)
        
        translationGame.resetGame()
        XCTAssertEqual(translationGame.numberOfCorrect.value, 0)
        XCTAssertEqual(translationGame.numberOfIncorrect.value, 0)
        
    }
    
    func test_game_over() {
        
    }
}
