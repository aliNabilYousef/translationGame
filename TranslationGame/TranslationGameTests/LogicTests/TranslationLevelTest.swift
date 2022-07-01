//
//  TranslationLevelTest.swift
//  TranslationGameTests
//
//  Created by Ali Youssef on 01/07/2022.
//

import XCTest
@testable import TranslationGame

class TranslationLevelTest: XCTestCase {
    
    func test_select_answer() {
        var level = TranslationLevel(question: "", options: [], answers: [])
        XCTAssertEqual(level.selectedAnswerId, -1)
        level.selectAnswer(number: 2)
        XCTAssertEqual(level.selectedAnswerId, 2)
    }
}
