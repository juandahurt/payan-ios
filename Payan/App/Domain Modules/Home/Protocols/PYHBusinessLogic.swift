//
//  PYHBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation


protocol PYHBusinessLogic {
    var worker: PYHDataAccessLogic { get }
    
    func checkCurrentVersion()
}
