//
//  PYCDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCDataAccessLogic {
    func getPlaces(completion: (([PYCPlace]) -> Void)?)
}
