//
//  PYFeedViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation
import CoreGraphics

class PYFeedViewModel: ObservableObject {
    @Published var loadedPercentage: Double = 0
    @Published var isLoading: Bool = true
    @Published var feedData: PYFeedPageData = .empty
    @Published var errorOccurred = false
    @Published var isNavBarVisible = true
    @Published var isSearchVisible = false
    
    private var currentPercentageAddition = 0.1
    private var lastScrollValue: CGFloat = .zero
    
    lazy var timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
        guard let self = self else { return }
        guard !self.errorOccurred else { return }
        guard self.loadedPercentage < 0.85 else { return }
        self.loadedPercentage += self.currentPercentageAddition
        self.currentPercentageAddition /= 1.15
    }
    
    let interactor: PYFeedBusinessLogic
    var onSuccess: (() -> Void)?
    
    init(interactor: PYFeedBusinessLogic, onSuccess: (() -> Void)? = nil) {
        self.interactor = interactor
        self.onSuccess = onSuccess
    }
    
    var stories: [PYStoryPreview] {
        feedData.stories
    }
    
    func getData() {
        loadedPercentage = 0
        currentPercentageAddition = 0.1
        isLoading = true
        timer.fire()
        interactor.getFeedData { [weak self] res in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                guard let self = self else { return }
                switch res {
                case .success(let data):
                    self.loadedPercentage = 1
                    self.feedData = data
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isLoading = false
                        self.timer.invalidate()
                        self.onSuccess?()
                    }
                case .failure(_):
                    self.loadedPercentage = 0
                    self.errorOccurred = true
                }
            }
        }
    }
    
    func showSearch() {
        isSearchVisible = true
    }
    
    func tryToUpdateNavBar(currentOffset value: CGPoint) {
        guard value.y <= 0 else { return }
        let diff = abs(value.y) - abs(lastScrollValue)
        if diff > 50 {
            lastScrollValue = value.y
            if isNavBarVisible {
                isNavBarVisible.toggle()
            }
            return
        }
        if diff < -50 {
            lastScrollValue = value.y
            if !isNavBarVisible {
                isNavBarVisible.toggle()
            }
        }
    }
}
