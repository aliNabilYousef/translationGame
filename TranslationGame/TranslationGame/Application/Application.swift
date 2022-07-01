//
//  Application.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import UIKit

final class Application {
    
    static let shared = Application()
    private let translationLogic: LogicProtocol
    private let translationGame: GameProtocol
    //The only reason for this initializer to is to make it private, however it can be used to feed data to the app
    private init() {
        translationLogic = TranslationLogic()
        translationGame = TranslationGame(translationLogic: translationLogic)
    }
    
    func configureMainInterface(in window: UIWindow?) {
        let vm = GameViewModel(with: translationGame)
        let vc = GameViewController()
        vc.bindToViewModel(viewModel: vm)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
