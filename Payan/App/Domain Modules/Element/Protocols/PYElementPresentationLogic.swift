//
//  PYElementPresentationLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

protocol PYElementPresentationLogic {
    var view: PYElementViewLogic? { get set }
    
    func showLoading()
    func showSections(_ sections: [PYElementSection])
}
