//
//  PYSearchFeedPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation
import SwiftUI
import Purace

struct PYSearchFeedPageView: View {
    var icon: some View {
        ZStack {
            Image("app")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
            Image("search-alt")
                .padding(.bottom, 20)
                .padding(.leading, 40)
        }
    }
    
    var searchBar: some View {
        ZStack {
            Color.black
                .opacity(0.05)
                .frame(height: 40)
                .cornerRadius(10)
            HStack {
                PuraceTextView("Buscar en Popayán...")
                    .opacity(0.5)
                Spacer()
            }.padding(.leading)
        }.padding(25)
            .onTapGesture {
                PYRoutingManager.shared.open(url: URL(string: "payan://search")!, animated: false)
            }
    }
    
    var body: some View {
        VStack {
            icon
            searchBar
        }.offset(x: 0, y: -50)
            .navigationBarHidden(true)
    }
}
