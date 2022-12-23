//
//  PYFeedSectionHeader.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import Purace
import SwiftUI

struct PYFeedSectionHeader: View {
    @Binding var showSkeleton: Bool
    let title: String
    var buttonTitle: String? = nil
    var buttonCallback: (() -> Void)?
    
    var body: some View {
        HStack {
            PuraceTextView(title, fontSize: 22, textColor: PuraceStyle.Color.N1, weight: .semibold)
                .lineLimit(1)
                .skeleton(with: showSkeleton, transition: .opacity)
                .multiline(lines: 1, scales: [0: 0.5])
                .frame(height: 20)
            
            Spacer(minLength: 0)
            
            if let buttonTitle, !showSkeleton {
                Button {
                    buttonCallback?()
                } label: {
                    PuraceTextView(buttonTitle, textColor: PuraceStyle.Color.N4, weight: .medium)
                }.buttonStyle(.plain)
            }
        }
    }
}
