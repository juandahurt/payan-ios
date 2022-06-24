//
//  PYOnboardingPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYOnboardingPageView: View {
    var placesPage: some View {
        VStack(spacing: 20) {
            ZStack {
                Image("shape-1")
                Image("ob-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 194, height: 162)
                    .clipped()
                    .cornerRadius(10)
                    .rotationEffect(.degrees(-12))
                    .offset(x: -50, y: 0)
                Image("ob-3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 161, height: 162)
                    .clipped()
                    .cornerRadius(10)
                    .rotationEffect(.degrees(10))
                    .offset(x: 50, y: 0)
                Image("ob-2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 148, height: 180)
                    .clipped()
                    .cornerRadius(10)
            }
            PuraceTextView("La ciudad blanca", fontSize: 20)
            PuraceTextView("Una de las ciudades más antiguas y mejor conservadas de América, lo que se ve reflejado en su centro histórico y tradiciones religiosas, reconocida por su arquitectura colonial y el cuidado de las fachadas.", textColor: PuraceStyle.Color.N4)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    var body: some View {
        TabView {
            placesPage
            PuraceTextView("hola")
        }.tabViewStyle(.page)
    }
}
