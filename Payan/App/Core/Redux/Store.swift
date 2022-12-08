//
//  Store.swift
//  Payan
//
//  Created by Juan Hurtado on 12/08/22.
//

import Combine
import Foundation

class AppStore<State, Action, Env>: ObservableObject {
    typealias Reducer = AnyReducer<State, Action, Env>
    
    @Published var state: State
    
    private let reducer: Reducer
    private let environment: Env
    private var cancellables: Set<AnyCancellable> = []
    
    private var verbose = false
    
    init(initialState: State, reducer: Reducer, environment: Env) {
        state = initialState
        self.reducer = reducer
        self.environment = environment
    }
    
    final func send(_ action: Action) {
        if verbose {
            print("sending action: \(action.self)")
        }
        guard let effect = reducer.update(state: &state, with: action, environment: environment) else {
            return
        }
        
        effect
            .receive(on: RunLoop.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
    
    func debug() -> Self {
        verbose = true
        return self
    }
}
