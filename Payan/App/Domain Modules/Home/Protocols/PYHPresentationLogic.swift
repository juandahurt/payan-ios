//
//  PYHPresentationLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


protocol PYHPresentationLogic {
    var view: PYHViewLogic? { get }
    
    func showLoading()
    func showAppNeedsUpdate(_ type: PYHAppVersionType)
    func showSections(_ sections: [PYHSection])
}
