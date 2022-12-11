//
//  PYFeedState.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Foundation

class PYFeedState {
    var isLoading = true
    var placeCategories: [PYPlaceCategory] = []
    var heroes: [PYHeroPreview] = []
    var stories: [PYStoryPreview] = []
    var loadingStoryIndex = -1
    var storyToBeShown: PYStoryData?
}
