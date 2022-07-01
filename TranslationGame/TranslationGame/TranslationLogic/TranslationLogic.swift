//
//  TranslationLogic.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

class TranslationLogic: LogicProtocol {
    
    private(set) var gameData: [String : String] = [:]
    private(set) var usedGameData: [String : String] = [:]
    
    private let correctWordPercentage: Int
    
    init(correctWordPercentage: Int = 25) {
        self.correctWordPercentage = correctWordPercentage
    }
    
    func isRight(level: LevelProtocol) -> Bool {
        guard let levelAnswer = level.options.first,
              let correctAnswer = gameData[level.question] else { return false }
        
        usedGameData[level.question] = correctAnswer
        if levelAnswer == correctAnswer {
            return level.selectedAnswerId == 0
        } else {
            return level.selectedAnswerId == 1
        }
    }
    
    func getGameData() {
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let wordsArray = try JSONSerialization.jsonObject(with: data) as? [[String: String]]
                for word in wordsArray ?? [] {
                    let currentWord: WordPairModel = try JSONDecoder().decode(WordPairModel.self, from: JSONSerialization.data(withJSONObject: word))
                    gameData[currentWord.firstLanguageWord] = currentWord.secondLanguageWord
                }
                print("Data parsed successfully \(gameData)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func getNextLevel() -> LevelProtocol {
        guard !gameData.isEmpty else { fatalError() } //this will insure that it will crash if the get data isnt called, so devs would realize that while developing
        let numberOfRandomWords: Int = 100 / correctWordPercentage
        var randomAnswers: [String] = []
        
        //this will fail when the word sample is lets say 5, and the user already played 2 games, this loop will never end
        while randomAnswers.count < numberOfRandomWords {
            let index: Int = Int(arc4random_uniform(UInt32(gameData.count)))
            let randomWord = Array(gameData.keys)[index]
            if usedGameData[randomWord] == nil {
                randomAnswers.append(randomWord)
            }
        }
        
        let randomQuestion = randomAnswers.randomElement()! //we are sure it is not nil
        let randomAnswer = gameData[randomAnswers.randomElement()!]! //we are also sure it is not nil
        return TranslationLevel(question: randomQuestion, options: [randomAnswer])
    }
    
    func resetGameData() {
        usedGameData = [:]
    }
}
