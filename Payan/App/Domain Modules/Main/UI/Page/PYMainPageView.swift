////
////  PYMainPageView.swift
////  Payan
////
////  Created by Juan Hurtado on 18/06/22.
////
//
//import Foundation
//import SwiftUI
//import Purace
//
//struct PYMainPageView: View {
//    let tabItems: [PYMainTabItem]
//    @StateObject var viewModel: PYMainViewModel
//    
//    init(viewModel: PYMainViewModel) {
//        self._viewModel = .init(wrappedValue: viewModel)
//        viewModel.checkIfUserHasSeenOnboarding()
//        tabItems = [
//            .init(
//                image: "home",
//                view: AnyView(PYFeedPageView())
//            ),
//            .init(
//                image: "menu",
//                view: AnyView(PYMenuBuilder().buildModule())
//            ),
//        ]
//    }
//    
//    var body: some View {
//        if viewModel.userHasSeenOnboarding {
//            TabView {
//                ForEach(tabItems.indices) { index in
//                    tabItems[index].view
//                        .tabItem {
//                            Image(tabItems[index].image)
//                        }
//                }
//            }.accentColor(PuraceStyle.Color.G1)
//        } else {
//            PYOnboardingPageView {
//                withAnimation {
//                    viewModel.saveUserSawOnboarding()
//                }
//            }
//        }
//    }
//}
