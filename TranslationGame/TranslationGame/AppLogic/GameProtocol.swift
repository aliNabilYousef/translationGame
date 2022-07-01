//
//  GameProtocol.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol GameProtocol {
    func resetGame()
    func verifyLevel(with level: LevelProtocol) -> Bool
    func getNextLevel()
    func gameOver()
    var gameLogic: LogicProtocol? { get set }
    var numberOfCorrect: BehaviorRelay<Int> { get set }
    var numberOfWrong: BehaviorRelay<Int> { get set }
    var timeInterval: Double { get set }
    var currentLevel: BehaviorRelay<LevelProtocol?> { get set }
}
