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
    var subtitle: String? = nil
    var buttonTitile: String? = nil
    var buttonCallback: (() -> Void)?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    PuraceTextView(title, fontSize: 22, textColor: PuraceStyle.Color.N1, weight: .medium)
                        .lineLimit(1)
                        .skeleton(with: showSkeleton, transition: .opacity)
                        .multiline(lines: 1, scales: [0: 0.5])
                        .frame(height: 20)
                    Spacer(minLength: 0)
                }
                if let subtitle {
                    HStack {
                        PuraceTextView(subtitle, fontSize: 14, textColor: PuraceStyle.Color.N4)
                            .lineLimit(1)
                            .skeleton(with: showSkeleton, transition: .opacity)
                            .multiline(lines: 1, scales: [0: 0.65])
                            .frame(height: 15)
                        Spacer(minLength: 0)
                    }
                }
            }
            
            Spacer(minLength: 0)
            
            if let buttonTitile, !showSkeleton {
                Button {
                    buttonCallback?()
                } label: {
                    PuraceTextView(buttonTitile, textColor: PuraceStyle.Color.N4, weight: .medium)
                }.buttonStyle(.plain)
            }
        }
    }
}
