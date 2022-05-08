//
//  PYElementBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

protocol PYElementBusinessLogic {
    var presenter: PYElementPresentationLogic { get }
    var worker: PYElementDataAccessLogic { get }
    
    func getElementData(id: String)
}
