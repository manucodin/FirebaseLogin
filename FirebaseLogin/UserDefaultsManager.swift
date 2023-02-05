//
//  UserDefaultsManager.swift
//  FirebaseLogin
//
//  Created by Manuel Rodriguez Sebastian on 26/1/23.
//

import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    
    var isAnyUserLogged: Bool {
        guard getUserEmail() != nil else { return false }
        
        return true
    }
    
    func save(email: String, password: String) {
        userDefaults.set(email, forKey: "email")
        userDefaults.set(password, forKey: "password")
    }
    
    func getUserEmail() -> String? {
        return userDefaults.value(forKey: "email") as? String
    }
}
