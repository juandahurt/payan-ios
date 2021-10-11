//
//  HomeSection.swift
//  Payan
//
//  Created by juandahurt on 5/10/21.
//

import Foundation

class HomeSection: Hashable {
    var id: String
    var title: String?
    var items: [HomeSectionItem]
    var type: HomeSectionType
    
    init(id: String = UUID().uuidString, title: String?, items: [HomeSectionItem], type: HomeSectionType) {
        self.id = id
        self.title = title
        self.items = items
        self.type = type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeSection, rhs: HomeSection) -> Bool {
        lhs.id == rhs.id
    }
}

class HomeSectionItem: Hashable {
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeSectionItem, rhs: HomeSectionItem) -> Bool {
        lhs.id == rhs.id
    }
}
