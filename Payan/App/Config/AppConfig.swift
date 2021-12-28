//
//  AppConfig.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct AppConfig {
    static var environment: AppEnvironment {
        guard let value = ProcessInfo().environment["env"] else {
            Console.log("'env' variable was not provided in scheme! Using default value.", level: .warn)
            return AppEnvironment.dev
        }
        guard let env = AppEnvironment(rawValue: value) else {
            Console.log("'env' variable provided in scheme is not supported! Using default value.", level: .warn)
            
            return AppEnvironment.dev
        }
        return env
    }
}

enum AppEnvironment: String {
    case dev = "dev"
    case test = "test"
}
