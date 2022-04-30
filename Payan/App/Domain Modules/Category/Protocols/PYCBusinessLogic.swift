//
//  PYCBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCBusinessLogic {
    var worker: PYCDataAccessLogic { get }
    var presenter: PYCPresentationLogic { get }
    
    func getPlaces(withTypeId typeId: String)
}
