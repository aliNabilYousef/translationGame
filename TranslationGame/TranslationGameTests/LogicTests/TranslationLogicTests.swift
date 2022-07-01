//
//  TranslationLogicTests.swift
//  TranslationGameTests
//
//  Created by Ali Youssef on 01/07/2022.
//

import XCTest
@testable import TranslationGame

class TranslationLogicTests: XCTestCase {
    let translationLogic = TranslationLogic()
    
    let correctTranslationEnglish = "(to) paint"
    let correctTranslationSpanish = "pintar"
    let wrongTranslationSpanish = "sentirse"
    
// if we set it up like that we will not be able to test the loading of the data
    
//    override func setUp() async throws {
//        translationLogic.getGameData()
//    }
    
    func test_right_answer() {
        translationLogic.getGameData()

        //correct translation success scenario
        var level = TranslationLevel(question: correctTranslationEnglish, options: [correctTranslationSpanish])
        level.selectAnswer(number: 0)
        XCTAssertTrue(translationLogic.isRight(level: level))
        
        //correct translation fail scenario
        var level1 = TranslationLevel(question: correctTranslationEnglish, options: [correctTranslationSpanish])
        level1.selectAnswer(number: 1)
        XCTAssertFalse(translationLogic.isRight(level: level1))
        
        //wrong translation success scenario
        var level2 = TranslationLevel(question: correctTranslationEnglish, options: [wrongTranslationSpanish])
        level2.selectAnswer(number: 0)
        XCTAssertFalse(translationLogic.isRight(level: level2))
        
        //wrong translation fail scenario
        var level3 = TranslationLevel(question: correctTranslationEnglish, options: [wrongTranslationSpanish])
        level3.selectAnswer(number: 1)
        XCTAssertTrue(translationLogic.isRight(level: level3))
    }
    
    func test_get_game_data() {
        XCTAssertTrue(translationLogic.gameData.isEmpty)
        translationLogic.getGameData()
        XCTAssertFalse(translationLogic.gameData.isEmpty)
    }
    
    func test_get_next_level() {
        translationLogic.getGameData()
        let level = translationLogic.getNextLevel()
        XCTAssertNil(translationLogic.usedGameData[level.question])
    }
    
    func test_usedGameData_insertions() {
        translationLogic.getGameData()
        let level = translationLogic.getNextLevel()
        let _ = translationLogic.isRight(level: level)
        XCTAssertNotNil(translationLogic.usedGameData[level.question])
    }
    
    func test_reset() {
        translationLogic.getGameData()
        let level = translationLogic.getNextLevel()
        let _ = translationLogic.isRight(level: level)
        
        XCTAssertFalse(translationLogic.usedGameData.isEmpty)
        
        translationLogic.resetGameData()
        XCTAssertTrue(translationLogic.usedGameData.isEmpty)
    }
}
