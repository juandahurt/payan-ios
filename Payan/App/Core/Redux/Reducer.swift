//
//  Reducer.swift
//  Payan
//
//  Created by Juan Hurtado on 12/08/22.
//

import Combine
import Foundation

class AnyReducer<State, Action, Env> {
    func update(state: inout State, with action: Action, environment: Env) -> AnyPublisher<Action, Never>? {
        fatalError("update(...) has not been implemented.")
    }
}
