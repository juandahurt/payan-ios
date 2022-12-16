//
//  PYFeedReducer.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Combine

class PYFeedReducer: AnyReducer<PYFeedState, PYFeedAction, String> {
    let repository: PYFeedDataAccessLogic
    
    init(repository: PYFeedDataAccessLogic) {
        self.repository = repository
    }
    
    override func update(state: inout PYFeedState, with action: PYFeedAction, environment: String) -> AnyPublisher<PYFeedAction, Never>? {
        switch action {
        case .getData:
            state.feedErrorOccured = false
            state.isLoading = true
            state.placeCategories = PYPlaceCategory.skeleton
            state.heroes = PYHeroPreview.skeleton
            state.stories = PYStoryPreview.skeleton
            return repository.getData()
                .map {
                    .showData($0)
                }
                .catch { _ in
                    Just<PYFeedAction>(.feedErrorOccured)
                }
                .eraseToAnyPublisher()
        case .showData(let data):
            state.isLoading = false
            state.placeCategories = data.placeCategories
            state.heroes = data.heroes
            state.stories = data.stories
            return nil
        case .loadStory(let id, let index):
            guard state.loadingStoryIndex == -1 else { return nil }
            state.storyErrorOccured = false
            state.loadingStoryIndex = index
            return repository.getStory(identifiedBy: id)
                .map { data in
                    .showStory(data)
                }
                .catch { _ in
                    Just<PYFeedAction>(.storyErrorOccured)
                }
                .eraseToAnyPublisher()
        case .showStory(let data):
            state.loadingStoryIndex = -1
            state.storyToBeShown = data
            return nil
        case .storyErrorOccured:
            state.storyErrorOccured = true
            state.loadingStoryIndex = -1
            return nil
        case .feedErrorOccured:
            state.feedErrorOccured = true
            return nil
        }
    }
}
