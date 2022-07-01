//
//  Application.swift
//  TranslationGame
//
//  Created by Ali Youssef on 01/07/2022.
//

import UIKit

final class Application {
    static let shared = Application()
    
    //The only reason for this initializer to is to make it private, however it can be used to feed data to the app
    private init() { }
    
    func configureMainInterface(in window: UIWindow?) {
        let logic = TranslationLogic()
        logic.getGameData()
    }
}
