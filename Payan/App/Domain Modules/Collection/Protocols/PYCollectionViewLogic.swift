//
//  PYCollectionViewLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionViewLogic: AnyObject {
    var typeId: String { get set }
    var interactor: PYCollectionBusinessLogic { get }
    
    func showLoading()
    func hideLoading()
    func renderCollection(_ colleciton: PYCollection)
}
