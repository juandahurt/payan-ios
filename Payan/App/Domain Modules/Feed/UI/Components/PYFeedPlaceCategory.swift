//
//  PYFeedPlaceCategory.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import Purace
import SkeletonUI
import SwiftUI

struct PYFeedPlaceCategory: View {
    @Binding var showSkeleton: Bool
    let link: String
    let image: String
    let title: String
    let numberOfPlaces: Int
    
    var body: some View {
        Button {
            guard let url = URL(string: link) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                PuraceImageView(url: URL(string: image))
                    .aspectRatio(contentMode: .fill)
                    .skeleton(with: showSkeleton, transition: .opacity)
                    .shape(type: .rounded(.radius(10, style: .circular)))
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 3)
                    .clipped()
                    .cornerRadius(10)
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            PuraceTextView(title, fontSize: 16, weight: .medium)
                                .skeleton(with: showSkeleton, transition: .opacity)
                                .multiline(lines: 1, scales: [0: 0.55])
                                .frame(height: 20)
                            
                            Spacer(minLength: 0)
                        }
                        
                        HStack {
                            PuraceTextView("\(numberOfPlaces) lugares", fontSize: 10, textColor: PuraceStyle.Color.N3)
                                .skeleton(with: showSkeleton, transition: .opacity)
                                .multiline(lines: 1, scales: [0: 0.25])
                                .frame(height: 12)
                            
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(20)
            .contentShape(Rectangle())
        }.buttonStyle(SquishableButton())
    }
}
