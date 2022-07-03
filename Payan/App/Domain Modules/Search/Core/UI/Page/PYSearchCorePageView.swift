//
//  PYSearchCorePageView.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation
import SwiftUI
import Purace

struct PYSearchCorePageView: View {
    @State var text: String = ""
    
    var searchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .onTapGesture {
                    PYRoutingManager.shared.pop(animated: false)
                }
            PuraceTextField("Buscar", text: $text)
        }
        .padding(16)
        .background(
            Color.white
        )
    }
    
    var body: some View {
        VStack {
            searchBar
            Spacer()
                .navigationBarHidden(true)
        }.background(Color.black.opacity(0.05))
    }
}
