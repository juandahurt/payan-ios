//
//  PYAboutBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation
import SwiftUI

class PYAboutBuilder: PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController? {
        let vc = UIHostingController(rootView: PYAboutPageView())
        vc.navigationController?.navigationBar.isHidden = true
        return vc
    }
}
