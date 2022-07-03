//
//  PYSearchCoreViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

class PYSearchCoreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var results: [PYSearchResult] = []
    @Published var isLoading = false
    private var cancellable: AnyCancellable? = nil
    
    init() {
        cancellable = $searchText
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // TODO: Search text
                    self.isLoading = false
                    self.results = PYSearchResult.dummy
                }
            }
    }
    
    func result(at index: Int) -> PYSearchResult {
        results[index]
    }
    
    func item(of result: PYSearchResult, at index: Int) -> PYSearchResultItem {
        result.items[index]
    }
}
