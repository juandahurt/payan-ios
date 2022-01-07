//
//  AppVersion.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation

struct AppVersion: Decodable {
    var number: String
    var type: AppVersionType
}

enum AppVersionType: Int, Decodable {
    case optional = 0
    case mandatory = 1
}
