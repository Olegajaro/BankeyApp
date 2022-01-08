//
//  LocalState.swift
//  BankeyApp
//
//  Created by Олег Федоров on 08.01.2022.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnBoarded
    }
    
    public static var hasOnBoarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnBoarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnBoarded.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
