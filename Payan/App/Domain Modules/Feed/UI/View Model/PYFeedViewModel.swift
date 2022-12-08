//
//  PYFeedViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Combine
import Foundation
import CoreGraphics

class PYFeedViewModel: ObservableObject {
    @Published var loadedPercentage: Double = 0
    @Published var isLoading: Bool = true
    @Published var feedData: PYFeedPageData = .empty
    @Published var errorOccurred = false
    @Published var isSearchVisible = false
    @Published var storyData: PYStoryData?
    @Published var loadingStoryIndex = -1
    @Published var seenStories: [String] = []
    @Published var errorMessage = ""
    @Published var feedErrorOccurred = false
    @Published var storyErrorOccurred = false
    
    private var currentPercentageAddition = 0.1
    private var lastScrollValue: CGFloat = .zero
    
    private var cancellables = Set<AnyCancellable>()
    
//    lazy var timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
//        guard let self = self else { return }
//        guard !self.feedErrorOccurred else { return }
//        guard self.loadedPercentage < 0.85 else { return }
//        self.loadedPercentage += self.currentPercentageAddition
//        self.currentPercentageAddition /= 1.15
//    }
    
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
//        loadedPercentage = 0
//        currentPercentageAddition = 0.1
//        isLoading = true
//        timer.fire()
//        interactor.getFeedData { [weak self] res in
//            guard let self = self else { return }
//            self.isLoading = false
//            switch res {
//            case .success(let data):
//                self.loadedPercentage = 1
//                self.feedData = data
//                self.feedErrorOccurred = false
//            case .failure(_):
//                self.loadedPercentage = 0
//                self.feedErrorOccurred = true
//                self.errorMessage = "Ha ocurrido un error inesperado."
//            }
//        }
    }
    
    func showSearch() {
        isSearchVisible = true
    }
    
    func getStory(id: String, index: Int) {
        errorOccurred = false
        loadingStoryIndex = index
        interactor.getStory(identifiedBy: id)
            .receive(on: RunLoop.main)
            .catch { [weak self] _ -> Empty<PYStoryData, Never> in
                let empty = Empty<PYStoryData, Never>()
                guard let self = self else { return empty }
                self.loadingStoryIndex = -1
                self.storyErrorOccurred = true
                self.errorMessage = "No fue posible cargar la historia."
                self.errorOccurred = true
                self.storyData = nil
                return empty
            }
            .sink { [weak self] data in
                guard let self = self else { return }
                self.storyData = data
                self.loadingStoryIndex = -1
            }
            .store(in: &cancellables)
    }
    
    func saveSeenStory(hash: String) {
        interactor.saveSeenStory(hash: hash)
        updateSeenStories()
    }
    
    func updateSeenStories() {
        seenStories = interactor.getSeenStories()
    }
}
