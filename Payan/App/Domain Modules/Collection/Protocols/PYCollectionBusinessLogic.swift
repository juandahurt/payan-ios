//
//  PYCollectionBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionBusinessLogic {
    var worker: PYCollectionDataAccessLogic { get }
    var presenter: PYCollectionPresentationLogic { get }
    
    func getCollection(withTypeId typeId: String)
}
