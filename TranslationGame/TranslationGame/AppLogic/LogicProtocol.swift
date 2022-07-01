//
//  LogicProtocol.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation

protocol LogicProtocol {
    func isRight(level: LevelProtocol) -> Bool
    func getGameData()
    func getNextLevel() -> LevelProtocol
    func resetGameData()
}
