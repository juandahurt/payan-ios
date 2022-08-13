//
//  Store.swift
//  Payan
//
//  Created by Juan Hurtado on 12/08/22.
//

import Combine
import Foundation

class AnyStore<State, Action, Env>: ObservableObject {
    typealias Reducer = AnyReducer<State, Action, Env>
    
    @Published private(set) var state: State
    
    private let reducer: Reducer
    private let environment: Env
    private var cancellables: Set<AnyCancellable> = []
    
    init(initialState: State, reducer: Reducer, environment: Env) {
        state = initialState
        self.reducer = reducer
        self.environment = environment
    }
    
    final func send(_ action: Action) {
        guard let effect = reducer.update(state: &state, with: action, environment: environment) else {
            return
        }
        
        effect
            .receive(on: RunLoop.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
}
