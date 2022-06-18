//
//  PYModule.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 26/04/22.
//

import Foundation
import UIKit

protocol PYModule {
    var host: String { get }
    
    func getViewController(params: [URLQueryItem]) -> UIViewController?
}
