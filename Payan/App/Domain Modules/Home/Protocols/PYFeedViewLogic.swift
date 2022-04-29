//
//  PYFeedViewLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


protocol PYFeedViewLogic: AnyObject {
    var interactor: PYFeedBusinessLogic { get }
    var router: PYFeedRoutingLogic { get }

    func showUpdateModal(image: UIImage, title: String, content: String, dismissable: Bool)
    func renderSections(_ sections: [PYFeedSection])
    func showGenericError()
}
