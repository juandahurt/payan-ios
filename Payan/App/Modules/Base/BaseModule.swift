//
//  BaseModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

protocol BaseModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController
}
