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
            fatalError("Info.plist was not found!")
        }
        guard let value = dict[key] as? T else {
            fatalError("The key \(key) doesn't exist in the Info.plist file or you have provided a wrong type")
        }
        wrappedValue = value
    }
}
