//
//  PYCWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation

#warning("TODO: implement data access logic")
class PYCWorker: PYCDataAccessLogic {
    func getPlaces(completion: (([PYCPlace]) -> Void)?) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            completion?(PYCPlace.dummy)
        }
    }
}
