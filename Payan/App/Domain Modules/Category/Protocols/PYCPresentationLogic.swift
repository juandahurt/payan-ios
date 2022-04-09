//
//  PYCPresentationLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCPresentationLogic {
    var view: PYCViewLogic? { get }
    
    func showLoading()
    func hideLoading()
    func showPlaces()
}
