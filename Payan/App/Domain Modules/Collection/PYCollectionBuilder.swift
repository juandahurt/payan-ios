//
//  PYCollectionBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit
import SwiftUI


final class PYCollectionBuilder: Route {
    var path: String = ""
    
    var builder: ([URLQueryItem]) -> UIViewController? = { params in
        var type: String = ""
        var categoryId: String?
        params.forEach { param in
            if param.name == "type" {
                type = param.value ?? ""
            }
            if param.name == "category_id" {
                categoryId = param.value ?? ""
            }
        }
        return UIHostingController(rootView: PYCollectionPageView(type: type, categoryId: categoryId))
    }
}
