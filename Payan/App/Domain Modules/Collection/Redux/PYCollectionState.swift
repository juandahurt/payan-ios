//
//  PYCollectionState.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Foundation

// MARK: - Base State
protocol PYCollectionState {}


// MARK: - Loading State
final class PYCollectionLoadingState: PYCollectionState {}


// MARK: - Error State
final class PYCollectionErrorState: PYCollectionState {}


// MARK: - Success State
final class PYCollectionSuccessState: PYCollectionState {
    let data: PYCollection
    
    init(data: PYCollection) {
        self.data = data
    }
}
