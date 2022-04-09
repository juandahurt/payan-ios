//
//  PYCBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCBusinessLogic {
    #warning("TODO: create place model")
    var places: [String] { get }
    var presenter: PYCPresentationLogic { get }
    
    func getPlaces()
}
