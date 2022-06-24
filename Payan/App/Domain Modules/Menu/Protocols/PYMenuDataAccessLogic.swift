//
//  PYMenuDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

protocol PYMenuDataAccessLogic {
    func getItems() -> AnyPublisher<[PYMenuItem], Error>
}
