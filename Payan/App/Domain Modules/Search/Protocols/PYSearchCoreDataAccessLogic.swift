//
//  PYSearchCoreDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

protocol PYSearchCoreDataAccessLogic {
    func fetchResults(from text: String) -> AnyPublisher<[PYSearchResult], Error>
}
