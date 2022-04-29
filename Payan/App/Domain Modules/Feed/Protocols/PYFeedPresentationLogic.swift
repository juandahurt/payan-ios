//
//  PYFeedPresentationLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


protocol PYFeedPresentationLogic {
    var view: PYFeedViewLogic? { get }
    
    func showLoading()
    func showSections(_ sections: [PYFeedSection])
    func showError()
}
