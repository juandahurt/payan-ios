//
//  PYFeedAction.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Foundation

enum PYFeedAction {
    case getData
    case showData(PYFeedPageData)
    case loadStory(id: String, deeplink: String, index: Int)
    case showStory(PYStoryData)
}
