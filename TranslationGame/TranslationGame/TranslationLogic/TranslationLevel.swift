//
//  TranslationLevel.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

struct TranslationLevel: LevelProtocol {
    var question: String
    var options: [String]
    var answers: [String] = ["correct".localized, "wrong".localized]
    //why is answers an array I hear you ask, well in our case we only have right or wrong, but in the app we sometimes select the right answer, so that can help with that.
    var selectedAnswerId: Int = -1
    
    mutating func selectAnswer(number id: Int) {
        selectedAnswerId = id
    }
}
