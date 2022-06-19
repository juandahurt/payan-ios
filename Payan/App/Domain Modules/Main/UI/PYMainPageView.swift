//
//  PYMainPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYMainPageView: View {
    var body: some View {
        TabView {
            PYFeedPageView()
                .tabItem {
                    Image("home")
                }
            PYMenuPageView()
                .tabItem {
                    Image("menu")
                }
        }.accentColor(PuraceStyle.Color.G1)
    }
}
