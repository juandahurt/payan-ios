//
//  PYMenuPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYMenuPageView: View {
    func row(title: String) -> some View {
        VStack(spacing: 0) {
            HStack {
                PuraceTextView(title, weight: .medium)
                Spacer()
            }.padding(.leading)
                .padding(.vertical, 10)
            Divider().opacity(0.6)
        }
    }
    
    func row(title: String, subtitle: String) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 5) {
                HStack {
                    PuraceTextView(title, weight: .medium)
                    Spacer()
                }
                HStack {
                    PuraceTextView(subtitle, textColor: PuraceStyle.Color.N4)
                    Spacer()
                }
            }.padding(.leading)
            .padding(.vertical, 10)
            Divider().opacity(0.6)
        }
    }
    
    var body: some View {
        ScrollView {
            PuraceTextView("Acerca de", fontSize: 22)
            VStack(spacing: 0) {
                row(title: "¿Qué es Payán?")
                row(title: "Código abierto")
                row(title: "Enviar comentarios")
                row(title: "Versión", subtitle: "2.0.0")
            }.padding(.top)
            Spacer()
        }
            .padding(.top, 25)
            .navigationBarHidden(true)
    }
}
