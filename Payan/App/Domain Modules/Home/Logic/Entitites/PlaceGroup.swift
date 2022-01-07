//
//  PlaceGroup.swift
//  Payan
//
//  Created by juandahurt on 9/11/21.
//

import Foundation

struct PlaceGroup: Decodable {
    var category: PlaceCategory
    var places: [Place]
}
