//
//  PYMainModule.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import UIKit
import SwiftUI

final class PYMainModule {
    static func getViewController() -> UIViewController {
        let view = PYMainPageView()
        return UIHostingController(rootView: view)
    }
}
