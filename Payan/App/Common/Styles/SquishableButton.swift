//
//  SquishableButton.swift
//  Payan
//
//  Created by Juan Hurtado on 9/09/22.
//

import Foundation
import SwiftUI

struct SquishableButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                Group {
                    if configuration.isPressed {
                        Color.white.opacity(0.25)
                    } else {
                        EmptyView()
                    }
                }
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
