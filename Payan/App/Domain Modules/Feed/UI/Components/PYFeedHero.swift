//
//  PYFeedHero.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import Purace
import SwiftUI

struct PYFeedHero: View {
    @Binding var showSkeleton: Bool
    let image: String
    let title: String
    let subtitle: String
    let tapHandler: () -> ()
    
    var body: some View {
        Button {
            tapHandler()
        } label: {
            HStack(spacing: 15) {
                PuraceImageView(url: URL(string: image))
                    .scaledToFill()
                    .frame(width: 53, height: 80)
                    .clipped()
                VStack(spacing: 5) {
                    HStack {
                        PuraceTextView(title, fontSize: 16, weight: .medium)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        PuraceTextView(subtitle, fontSize: 12, textColor: PuraceStyle.Color.N3)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                }
            }.background(Color.white)
                .cornerRadius(10)
        }.buttonStyle(SquishableButton())
            .skeleton(with: showSkeleton)
            .shape(type: .rounded(.radius(10, style: .circular)))
            .frame(height: 80)
    }
}
