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
    
    var description: some View {
        PuraceAccordionView(title: "¿Qué es Payán?") {
            PuraceTextView(
                "Payán es un proyecto sin ánimo de lucro cuyo principal objetivo es mostrar al mundo al belleza e historia que esconde la ciudad de Popayán, Colombia.",
                textColor: PuraceStyle.Color.N2
            ).padding()
                .background(Color.white)
        }
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
    
    var title: some View {
        VStack(spacing: 22) {
            icon
            
            VStack(spacing: 12) {
                PuraceTextView("Payan en iOS", fontSize: 18, weight: .medium)
                PuraceTextView("Versión \(version)")
            }
        }.padding(.top, 50)
    }
    
    var icon: some View {
        Image("app")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.05), radius: 4, y: 4)
    }
    
    var divider: some View {
        Divider()
            .opacity(0.65)
            .padding(.vertical, 25)
    }
    
    var footer: some View {
        VStack {
            PuraceTextView("Hecho en Popayán, Colombia.", fontSize: 10, textColor: .black.opacity(0.3))
            PuraceTextView("2022", fontSize: 10, textColor: .black.opacity(0.3))
        }.padding(.bottom)
    }
    
    var body: some View {
        PuraceScaffold(navBar: .init(title: "Acerca de", backOnTap: {
            PYRoutingManager.shared.pop()
        })) {
            VStack(spacing: 35) {
                title
                description
                Spacer()
                footer
            }
        }.background(PuraceStyle.Color.F1)
            .onAppear {
                AnalyticsManager.shared.trackView(
                    path: PYAboutConstants.Analytics.pageName
                )
            }
    }
}
