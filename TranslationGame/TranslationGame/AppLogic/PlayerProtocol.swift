//
//  PlayerProtocol.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

protocol PlayerProtocol {
    var name: String { get set }
    var level: String { get set }
    var highScore: String { get set }
    var id: String { get set }
}
