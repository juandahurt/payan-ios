//
//  PYFeedStoryPreview.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import Purace
import SwiftUI

struct PYFeedStoryPreview: View {
    @Binding var showSkeleton: Bool
    let title: String
    let seenStory: Bool
    let image: String
    let isLoading: Bool
    let onTapHandler: () -> ()
    
    var body: some View {
        VStack {
            ZStack {
                if !seenStory {
                    Circle()
                        .fill(.clear)
                        .background(PuraceStyle.Color.N2.clipShape(Circle()))
                        .clipped()
                        .skeleton(with: showSkeleton)
                        .shape(type: .circle)
                        .frame(width: 70, height: 70)
                } else {
                    Circle()
                        .fill(.black.opacity(0.35))
                        .skeleton(with: showSkeleton)
                        .shape(type: .circle)
                        .frame(width: 66, height: 66)
                }
                Circle()
                    .fill(Color.white)
                    .skeleton(with: showSkeleton)
                    .shape(type: .circle)
                    .frame(width: 65, height: 65)
                PuraceImageView(url: URL(string: image))
                    .aspectRatio(contentMode: .fill)
                    .skeleton(with: showSkeleton)
                    .shape(type: .circle)
                    .frame(width: 58, height: 58)
                    .overlay(
                        Group {
                            if isLoading {
                                ZStack {
                                    Color.white
                                        .opacity(0.5)
                                    ProgressView()
                                }
                            }
                        }
                    )
                    .clipShape(Circle())
                
            }
            PuraceTextView(title, fontSize: 10, weight: .medium)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(width: 70)
                .opacity(!seenStory ? 1 : 0.5)
        }.onTapGesture {
            onTapHandler()
        }
    }
}
