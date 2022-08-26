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
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .padding()
                .background(Color.black.opacity(0.001))
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
                .padding()
        }
            .frame(height: 50)
            .padding(.bottom, 50)
    }
    
    var description: some View {
        PuraceAccordionView(title: "¿Qué es Payán?") {
            PuraceTextView(
                "Payán es un proyecto sin ánimo de lucro cuyo principal objetivo es mostrar al mundo al belleza e historia que esconde la ciudad de Popayán, Colombia.",
                textColor: PuraceStyle.Color.N2
            ).padding()
        }
    }
    
    var title: some View {
        VStack {
            PuraceTextView("Payan en iOS", fontSize: 14, weight: .medium)
            PuraceTextView("Versión \(version)-\(buildNumber)", fontSize: 10, textColor: PuraceStyle.Color.N4)
        }.padding(.bottom)
    }
    
    var icon: some View {
        Image("app")
            .resizable()
            .scaledToFit()
            .frame(height: 80)
            .padding(.bottom, 20)
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
            description
            Spacer()
        }.navigationBarHidden(true)
    }
}
