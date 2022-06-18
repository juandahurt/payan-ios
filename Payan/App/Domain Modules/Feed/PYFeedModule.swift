//
//  PYFeedModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit
import SwiftUI

final class PYFeedModule: PYModule {
    var host: String = "feed"
    
    func getViewController(params: [URLQueryItem]) -> UIViewController? {
        let view = PYFeedPageView()
        return UIHostingController(rootView: view)
    }
}
