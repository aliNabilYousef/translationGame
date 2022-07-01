//
//  LevelProtocol.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

protocol LevelProtocol {
    var question: String { get set }
    var options: [String] { get set }
    var answers: [String] { get set }
    var selectedAnswerId: Int { get set }
    mutating func selectAnswer(number id: Int)
}
