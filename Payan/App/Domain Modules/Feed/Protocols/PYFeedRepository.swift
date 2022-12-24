//
//  PYFeedRepository.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Combine

protocol PYFeedRepository {
    func getData() -> AnyPublisher<PYFeedPageData, Error>
    func getStory(identifiedBy id: String) -> AnyPublisher<PYStoryData, Error>
}
