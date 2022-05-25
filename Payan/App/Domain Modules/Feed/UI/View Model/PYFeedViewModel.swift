//
//  PYFeedViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

class PYFeedViewModel: ObservableObject {
    @Published var loadedPercentage: Double = 0
    @Published var isLoading: Bool = true
    @Published var feedData: PYFeedPage = .empty
    @Published var snackbarIsVisible = false
    
    lazy var timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
        guard let self = self else { return }
        guard self.loadedPercentage < 0.7 else { return }
        self.loadedPercentage += 0.1
    }
    
    let interactor: PYFeedBusinessLogic
    
    init(interactor: PYFeedBusinessLogic = PYFeedInteractor(worker: PYFeedNetworkWorker())) {
        self.interactor = interactor
    }
    
    private func showSnackbar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.snackbarIsVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.snackbarIsVisible = false
            }
        }
    }
    
    func getData() {
        loadedPercentage = 0
        isLoading = true
        timer.fire()
        interactor.getFeedData { [weak self] res in
            guard let self = self else { return }
            self.loadedPercentage = 1
            switch res {
            case .success(let data):
                self.feedData = data
            case .failure(_): break
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
                self.timer.invalidate()
                self.showSnackbar()
            }
        }
    }
}
