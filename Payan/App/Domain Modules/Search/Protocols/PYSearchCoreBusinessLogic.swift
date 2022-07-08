//
//  PYSearchCoreBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

protocol PYSearchCoreBusinessLogic {
    func search(text: String) -> AnyPublisher<[PYSearchResult], Error>
}
