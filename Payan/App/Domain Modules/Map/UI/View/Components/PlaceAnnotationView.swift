//
//  PlaceAnnotationView.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import SwiftUI

struct PlaceAnnotationView: View {
    let category: PlaceCategory
    
    var onTap: (() -> Void)?
    
    var body: some View {
        ZStack {
            Image("pin")
                .resizable()
                .frame(width: 36, height: 45)
            Image(category.rawValue.lowercased())
                .resizable()
                .frame(width: 20, height: 20)
                .offset(x: 0, y: -5)
        }
        .onTapGesture {
            onTap?()
        }
    }
}
