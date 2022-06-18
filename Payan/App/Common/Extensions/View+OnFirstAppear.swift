//
//  View+OnFirstAppear.swift
//  Payan
//
//  Created by Juan Hurtado on 26/05/22.
//
import Foundation
import SwiftUI

struct OnFirstAppearModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnFirstAppearModifier(perform: action))
    }
}
