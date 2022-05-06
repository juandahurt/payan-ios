//
//  PYCollectionPresentationLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionPresentationLogic {
    var view: PYCollectionViewLogic? { get }
    
    func showLoading()
    func showCollection(_ collection: PYCollection)
    func showGenericError()
}
