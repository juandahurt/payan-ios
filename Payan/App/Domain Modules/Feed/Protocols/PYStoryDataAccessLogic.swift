//
//  PYStoryDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Combine

protocol PYStoryDataAccessLogic {
    func getStory(id: String) -> AnyPublisher<PYStoryData, Error>
}
