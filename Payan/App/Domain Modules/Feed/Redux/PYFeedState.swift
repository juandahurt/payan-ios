//
//  PYFeedState.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Foundation

class PYFeedState {
    var title: String = PYFeedConstants.Wordings.goodMornig
    var isLoading = true
    var placeCategories: [PYPlaceCategory] = []
    var heroes: [PYHeroPreview] = []
    var stories: [PYStoryPreview] = []
    var seenStories: [String] = []
    var loadingStoryIndex = -1
    var storyToBeShown: PYStoryData?
    var storyErrorOccured = false
    var feedErrorOccured = false
}
