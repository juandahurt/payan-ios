//
//  PYOnboardingBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation

protocol PYOnboardingBusinessLogic {
    var worker: PYOnboardingDataAccessLogic { get }
    
    /// Gets the list of items.
    ///
    /// Uses it's corresponding worker to get them.
    /// - Returns: The list of items.
    func getItems() -> [PYOnboardingItem]
    
    /// Tries to move to the next item.
    /// - Parameters:
    ///    - currentIndex: The current item index.
    ///    - numberOfItems: The total number of items.
    func next(currentIndex: inout Int, numberOfItems: Int)
}
