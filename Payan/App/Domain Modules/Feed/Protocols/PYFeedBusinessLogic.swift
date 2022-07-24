//
//  PYFeedBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation


protocol PYFeedBusinessLogic {
    var worker: PYFeedDataAccessLogic { get }
    
    func getFeedData(completion: @escaping (Result<PYFeedPageData,Error>) -> Void)
}
