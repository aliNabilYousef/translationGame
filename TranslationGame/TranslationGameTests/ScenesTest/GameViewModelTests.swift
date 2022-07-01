//
//  GameViewModelTests.swift
//  TranslationGameTests
//
//  Created by Ali Youssef on 02/07/2022.
//

import XCTest
@testable import TranslationGame

class GameViewModelTests: XCTestCase {

    let mockLogic = MockTranslationLogic()
    lazy var mockGame = MockTranslationGame(translationLogic: mockLogic)
    lazy var viewModel = GameViewModel(with: mockGame)
    
    func test_select_answer() {
        viewModel.currentLevel.accept(TranslationLevel(question: "", options: []))
        viewModel.selectAnswer(index: 0)
        XCTAssertTrue((viewModel.game as! MockTranslationGame).didVerify)
        XCTAssertTrue((viewModel.game?.gameLogic as! MockTranslationLogic).didTriggerIsRight)
    }
    
    func test_game_over_trigger() {
        viewModel.gameOver()
        XCTAssertTrue((viewModel.game as! MockTranslationGame).didTriggerGameOver)
    }
    
    func test_reset() {
        viewModel.game?.resetGame()
        XCTAssertTrue((viewModel.game as! MockTranslationGame).didReset)
    }
    
}
