//
//  Environment.swift
//  Payan
//
//  Created by juandahurt on 2/01/22.
//

import Foundation

struct Environment {
    static let current = Environment()
    
    private init() {}
    
    @EnviromentValue<String>("API_URL") private(set) var apiUrl: String
}

@propertyWrapper struct EnviromentValue<T> {
    var wrappedValue: T
    
    init(_ key: String) {
        guard let dict = Bundle.main.infoDictionary else {
            Console.log("Info.plist was not found!", level: .error)
            fatalError()
        }
        guard let value = dict[key] as? T else {
            Console.log("The key \(key) doesn't exist in the Info.plist file or you have provided a wrong type", level: .error)
            fatalError()
        }
        wrappedValue = value
    }
}
