//
//  PYMenuLocalWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

class PYMenuLocalWorker: PYMenuDataAccessLogic {
    enum MenuError: Error {
        case urlMalformed
        case unableToGetData
    }
    
    func getSections() -> AnyPublisher<[PYMenuSection], Error> {
        Just(())
            .tryMap { Void -> URL in
                guard let url = Bundle.main.url(forResource: "MenuItems", withExtension: "plist") else {
                    throw MenuError.urlMalformed
                }
                return url
            }
            .tryMap { (url: URL) -> Data in
                guard let data = try? Data(contentsOf: url) else {
                    throw MenuError.unableToGetData
                }
                return data
            }
            .tryMap { (data: Data) -> [PYMenuSection] in
                let decoder = PropertyListDecoder()
                let items = try decoder.decode([PYMenuSection].self, from: data)
                return items
            }
            .eraseToAnyPublisher()
    }
}
