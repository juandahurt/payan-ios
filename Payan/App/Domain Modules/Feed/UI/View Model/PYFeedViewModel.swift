//
//  PYFeedViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

class PYFeedViewModel: ObservableObject {
    @Published var feedData: PYFeedPageDTO = .empty
    
    let interactor: PYFeedBusinessLogic
    
    init(interactor: PYFeedBusinessLogic = PYFeedInteractor(worker: PYFeedNetworkWorker())) {
        self.interactor = interactor
    }
    
    func getData() {
        interactor.getFeedData { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(let data):
                self.feedData = data
            case .failure(_): break
            }
        }
    }
}
