//
//  CurrentPlayer.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

struct CurrentPlayer: PlayerProtocol {
    var name: String
    var level: String
    var highScore: String
    var id: String
    
    init() {
        //although i know this will not be used in my scope but why not
        name = "Ali Youssef"
        level = "Highest level"
        highScore = "Highest score"
        id = UUID().uuidString
    }
    
}
