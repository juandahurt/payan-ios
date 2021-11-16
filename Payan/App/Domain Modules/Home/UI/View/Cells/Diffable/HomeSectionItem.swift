//
//  HomeSectionItem.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation

class HomeSectionItem: Hashable {
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeSectionItem, rhs: HomeSectionItem) -> Bool {
        lhs.id == rhs.id
    }
}

class HomeLoadingItem: HomeSectionItem {}

class HomePlaceItem: HomeSectionItem {
    var place: Place
    
    init(place: Place) {
        self.place = place
    }
}
