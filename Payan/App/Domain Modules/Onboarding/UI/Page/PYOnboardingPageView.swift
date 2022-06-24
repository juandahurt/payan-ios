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
    @State var selectedPage = 0
    @State var buttonOpacity: Double = 0
    
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
    
    var heroesPage: some View {
        VStack(spacing: 20) {
            ZStack {
                Image("shape-2")
                Image("ob-4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 114.5, height: 185.42)
                    .clipped()
                    .cornerRadius(10)
                    .rotationEffect(.degrees(-12))
                    .offset(x: -50, y: 0)
                Image("ob-5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 114.5, height: 185.42)
                    .clipped()
                    .cornerRadius(10)
                    .rotationEffect(.degrees(10))
                    .offset(x: 50, y: 0)
                Image("ob-6")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 114.5, height: 185.42)
                    .clipped()
                    .cornerRadius(10)
            }
            PuraceTextView("Cuna de próceres", fontSize: 20)
            PuraceTextView(" Popayán ha sido cuna de importantes personajes colombianos, incluyendo a expresidentes del país, líderes de la Independencia y poetas célebres.", textColor: PuraceStyle.Color.N4)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    var continueButton: some View {
        Group {
            PuraceButtonView("Ir a Popayán", fontSize: 16)
                .opacity(buttonOpacity)
                .animation(.easeIn(duration: 0.2))
        }.frame(height: UIScreen.main.bounds.height * 0.2)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                placesPage
                    .tag(0)
                heroesPage
                    .tag(1)
            }.tabViewStyle(.page)
            continueButton
        }.onChange(of: selectedPage) { newValue in
            buttonOpacity = newValue == 1 ? 1 : 0
        }
    }
}
