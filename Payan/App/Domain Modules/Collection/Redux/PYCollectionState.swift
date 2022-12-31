//
//  PYCollectionState.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Foundation

// MARK: - Base State
class PYCollectionState: Equatable {
    let id = UUID().uuidString
    var errorHasOcurred = false
    
    static func == (lhs: PYCollectionState, rhs: PYCollectionState) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - Loading State
final class PYCollectionLoadingState: PYCollectionState {
    let data: PYCollection
    
    init(data: PYCollection) {
        self.data = data
    }
}


// MARK: - Error State
final class PYCollectionErrorState: PYCollectionState {
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
}


// MARK: - Success State
final class PYCollectionSuccessState: PYCollectionState {
    let data: PYCollection
    
    init(data: PYCollection) {
        self.data = data
    }
}
