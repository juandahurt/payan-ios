//
//  PYCollectionElement.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


struct PYCollectionElement: Decodable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var image: String
    var deepLink: String
    
    enum CodingKeys: String, CodingKey {
        case title, deepLink
        case image = "image_url"
    }
}
