//
//  PYFeedBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Combine
import Foundation

protocol PYFeedBusinessLogic {
    var worker: PYFeedDataAccessLogic { get }
    
    func getFeedData(completion: @escaping (Result<PYFeedPageData,Error>) -> Void)
    func getStory(identifiedBy id: String) -> AnyPublisher<PYStoryData, Error>
}
