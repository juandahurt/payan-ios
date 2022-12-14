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
            state.isLoading = true
            state.placeCategories = PYPlaceCategory.skeleton
            state.heroes = PYHeroPreview.skeleton
            state.stories = PYStoryPreview.skeleton
            return repository.getData()
                .map {
                    .showData($0)
                }
                .catch { _ in
                    Empty<PYFeedAction, Never>()
                }
                .eraseToAnyPublisher()
        case .showData(let data):
            state.isLoading = false
            state.placeCategories = data.placeCategories
            state.heroes = data.heroes
            state.stories = data.stories
            return nil
        case .loadStory(let id, let deeplink, let index):
            state.loadingStoryIndex = index
            return repository.getStory(identifiedBy: id)
                .map { data in
                    .showStory(data)
                }
                .catch { _ in
//                    state.loadingStoryIndex = -1
                    // TODO: return `.storyError` action
                    return Empty<PYFeedAction, Never>()
                }
                .eraseToAnyPublisher()
        case .showStory(let data):
            state.loadingStoryIndex = -1
            state.storyToBeShown = data
            return nil
        }
    }
}
