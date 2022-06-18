//
//  PYFeedDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation


protocol PYFeedDataAccessLogic {
    func getData(completion: @escaping (Result<PYFeedPage, Error>) -> Void)
}
