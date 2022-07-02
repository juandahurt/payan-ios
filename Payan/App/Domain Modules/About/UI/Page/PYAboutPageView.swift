//
//  PYAboutPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation
import SwiftUI
import Purace

struct PYAboutPageView: View {
    var navBar: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .onTapGesture {
                    PYRoutingManager.shared.pop()
                }
            Spacer()
            PuraceTextView("Acerca de", fontSize: 16, weight: .medium)
            Spacer()
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .opacity(0)
        }
            .padding()
            .frame(height: 50)
            .padding(.bottom, 50)
    }
    
    var description: some View {
        PuraceTextView(
            "Payán es un proyecto sin ánimo de lucro cuyo principal objetivo es mostrar al mundo al belleza e historia que esconde el centro histórico de la ciudad de Popayán, Colombia."
        )
            .multilineTextAlignment(.center)
            .padding(.horizontal, 50)
//            .padding(.vertical, 30)
    }
    
    var title: some View {
        VStack {
            PuraceTextView("Payan en iOS", weight: .medium)
            PuraceTextView("Versión 2.0.0", fontSize: 10, textColor: PuraceStyle.Color.N4)
        }
    }
    
    var icon: some View {
        Image("app")
            .resizable()
            .scaledToFit()
            .frame(height: 80)
            .padding(.bottom, 20)
    }
    
    var evaluateButton: some View {
        PuraceButtonView("Evaluar en la App Store", fontSize: 14) {
            // TODO: Go to the app store
        }
    }
    
    var divider: some View {
        Divider()
            .opacity(0.65)
            .padding(.vertical, 25)
    }
    
    var body: some View {
        VStack {
            navBar
            icon
            title
            divider
            description
            divider
            evaluateButton
            Spacer()
        }.navigationBarHidden(true)
    }
}
