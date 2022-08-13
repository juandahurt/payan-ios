//
//  PYCollectionStore.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Foundation

class PYCollectionStore: AnyStore<PYCollectionState, PYCollectionAction, PYCollectionEnvironment>, Equatable {
    static func == (lhs: PYCollectionStore, rhs: PYCollectionStore) -> Bool {
        lhs.state == rhs.state
    }
}
