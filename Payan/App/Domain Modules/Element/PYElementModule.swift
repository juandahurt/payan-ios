//
//  PYElementModule.swift
//  Payan
//
//  Created by Juan Hurtado on 6/05/22.
//

import Foundation
import UIKit

final class PYElementModule: PYModule {
    var host: String = "element"
    
    func getViewController(params: [URLQueryItem]) -> UIViewController? {
        guard params.count == 1, params[0].name == "id", let id = params[0].value else { return nil }
        let vc = PYElementViewController()
        return vc
    }
}
