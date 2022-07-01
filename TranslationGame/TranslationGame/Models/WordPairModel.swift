//
//  WordPairModel.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

class WordPairModel: Decodable {
    
    var firstLanguageWord: String
    var secondLanguageWord: String
    
    enum CodingKeys: String, CodingKey {
        case firstLanguageWord = "text_eng"
        case secondLanguageWord = "text_spa"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstLanguageWord = try values.decode(String.self, forKey: .firstLanguageWord)
        secondLanguageWord = try values.decode(String.self, forKey: .secondLanguageWord)
    }
}
