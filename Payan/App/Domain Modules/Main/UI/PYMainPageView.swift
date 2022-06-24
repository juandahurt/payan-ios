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
    let tabItems: [PYMainTabItem]
    
    init() {
        tabItems = [
            .init(
                image: "home",
                view: AnyView(PYFeedPageView())
            ),
            .init(
                image: "menu",
                view: AnyView(PYMenuBuilder().buildModule())
            ),
        ]
    }
    
    var body: some View {
        TabView {
            ForEach(tabItems.indices) { index in
                tabItems[index].view
                    .tabItem {
                        Image(tabItems[index].image)
                    }
            }
        }.accentColor(PuraceStyle.Color.G1)
    }
}
