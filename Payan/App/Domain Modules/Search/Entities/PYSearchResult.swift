//
//  PYSearchResult.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Foundation

struct PYSearchResult: Decodable {
    var title: String
    var items: [PYSearchResultItem]
}
