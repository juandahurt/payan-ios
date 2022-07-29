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
    
    var continueOnTap: () -> Void
    
    var placesPage: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 20) {
                PuraceTextView("La ciudad blanca", fontSize: 24)
                    .multilineTextAlignment(.leading)
                PuraceTextView("Una de las ciudades más antiguas y mejor conservadas de América, lo que se ve reflejado en su centro histórico y tradiciones religiosas.", textColor: PuraceStyle.Color.N4)
                    .multilineTextAlignment(.leading)
            }.padding(.horizontal, 40)
            
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
        }
    }
    
    var heroesPage: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 20) {
                PuraceTextView("Cuna de próceres", fontSize: 24)
                    .multilineTextAlignment(.leading)
                PuraceTextView("Popayán ha sido cuna de importantes personajes colombianos, incluyendo a expresidentes del país, líderes de la Independencia y poetas célebres.", textColor: PuraceStyle.Color.N4)
                    .multilineTextAlignment(.leading)
            }.padding(.horizontal, 40)
            
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
        }
    }
    
    var mainButton: some View {
        let type: PuraceButtonType
        switch selectedPage {
        case 1:
            type = .loud
        default:
            type = .custom(.clear, PuraceStyle.Color.N8, PuraceStyle.Color.N1)
        }
        return PuraceButtonView(getButtonText(), fontSize: 14, type: type) {
            if selectedPage == 1 {
                continueOnTap()
            } else {
                selectedPage += 1
            }
        }
    }
    
    var bottomBar: some View {
        HStack {
            indicators
            Spacer()
            mainButton
        }
            .padding(.horizontal, 35)
            .padding(.bottom, 20)
    }
    
    var indicators: some View {
        HStack {
            ForEach(0..<2) { index in
                Circle()
                    .fill(index == selectedPage ? PuraceStyle.Color.G1 : PuraceStyle.Color.G8)
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    func getButtonText() -> String {
        selectedPage == 1 ? "Continuar" : "Siguiente"
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { reader in
                TabView(selection: $selectedPage) {
                    placesPage
                        .tag(0)
                    heroesPage
                        .tag(1)
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .onChange(of: selectedPage) { currentPage in
                        reader.scrollTo(currentPage)
                    }
            }
            
            bottomBar
        }
    }
}
