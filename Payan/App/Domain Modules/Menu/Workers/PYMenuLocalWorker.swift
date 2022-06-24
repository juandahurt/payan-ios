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
    
    func getItems() -> AnyPublisher<[PYMenuItem], Error> {
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
            .tryMap { (data: Data) -> [PYMenuItem] in
                let decoder = PropertyListDecoder()
                let items = try decoder.decode([PYMenuItem].self, from: data)
                return items
            }
            .map { (items: [PYMenuItem]) -> [PYMenuItem] in
                // get actual version
                var itemsCopy = items
                if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    itemsCopy.append(.init(
                        title: "Versión",
                        content: appVersion,
                        isStatic: true)
                    )
                }
                return itemsCopy
            }
            .eraseToAnyPublisher()
    }
}
