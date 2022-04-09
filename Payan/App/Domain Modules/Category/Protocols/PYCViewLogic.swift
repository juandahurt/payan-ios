//
//  PYCViewLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCViewLogic {
    var interactor: PYCBusinessLogic { get }
    
    func showLoading()
    func hideLoading()
    func updatePlacesTable()
}
