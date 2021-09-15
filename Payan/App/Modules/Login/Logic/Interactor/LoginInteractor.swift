//
//  LoginInteractor.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation

protocol AnyLoginInteractor {
    var dataManager: AnyLoginDataManager { get set }
}

final class LoginInteractor: AnyLoginInteractor {
    var dataManager: AnyLoginDataManager
    
    init(dataManager: AnyLoginDataManager) {
        self.dataManager = dataManager
    }
    
    func login() {
        // TODO: Call the dataManager
    }
}
