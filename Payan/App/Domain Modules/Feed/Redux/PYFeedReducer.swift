//
//  PYFeedReducer.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Combine

class PYFeedReducer: AnyReducer<PYFeedState, PYFeedAction> {
    let repository: PYFeedRepository
    let seenStoryRepository: PYSeenStoryRepository
    
    init(repository: PYFeedRepository, seenStoryRepostory: PYSeenStoryRepository) {
        self.repository = repository
        self.seenStoryRepository = seenStoryRepostory
    }
    
    override func update(state: inout PYFeedState, with action: PYFeedAction) -> AnyPublisher<PYFeedAction, Never>? {
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
            state.seenStories = seenStoryRepository.getSeenStories()
            sortStories(state: state)
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
        case .saveStory(let hash):
            var hashes = state.seenStories
            let loadedHashes = state.stories.map { $0.hash }
            hashes = hashes.filter { loadedHashes.contains($0) }
            if !hashes.contains(hash) {
                hashes.append(hash)
            }
            seenStoryRepository.setSeenStories(hashes)
            state.seenStories = hashes
            sortStories(state: state)
            return nil
        }
    }
    
    private func sortStories(state: PYFeedState) {
        state.stories.sort {
            let seenA = state.seenStories.contains($0.hash) ? 1 : 0
            let seenB = state.seenStories.contains($1.hash) ? 1 : 0
            return seenA < seenB
        }
    }
}
