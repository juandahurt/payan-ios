//
//  LoginDataManager.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation

protocol AnyLoginDataManager {
    func login(with credential: String)
}

final class LoginDataManager: AnyLoginDataManager {
    func login(with credential: String) {
        
    }
}
