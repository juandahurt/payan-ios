//
//  PYElementViewLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

protocol PYElementViewLogic: AnyObject {
    var interactor: PYElementBusinessLogic { get }
    
    func renderSections(_ sections: [PYElementSection])
}
