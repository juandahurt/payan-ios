//
//  LocalLoginDataManager.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import Foundation

protocol LocalLoginDataManager {
    func saveSession(_ session: UserSession)
}

struct UserDefaultsLoginDataManager: LocalLoginDataManager {
    func saveSession(_ session: UserSession) {
        if let enconded = try? JSONEncoder().encode(session) {
            UserDefaults.standard.set(enconded, forKey: "UserSession")
        }
    }
}
