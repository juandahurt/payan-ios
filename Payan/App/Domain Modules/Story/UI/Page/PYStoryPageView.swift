//
//  PYStoryPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Foundation
import SwiftUI
import Purace

struct PYStoryPageView: View {
    @StateObject var viewModel = PYStoryViewModel()
    
    var close: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.1))
                            .frame(width: 40, height: 40)
                    )
                    .onTapGesture {
                        PYRoutingManager.shared.dismiss()
                    }
                    .padding(30)
            }
            Spacer()
        }
    }
    
    var indicators: some View {
        VStack {
            Spacer()
            HStack(spacing: 3) {
                ForEach(viewModel.chapters.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white)
                        .opacity(index == viewModel.currentIndex ? 1 : 0.4)
                        .frame(height: 4)
                }
            }.padding(.bottom, 15)
                .padding(.horizontal, 10)
        }
    }
    
    var tapHandlers: some View {
        HStack {
            Color.black.opacity(0.001)
                .onTapGesture {
                    viewModel.back()
                }
            Color.black.opacity(0.001)
                .onTapGesture {
                    viewModel.next()
                }
        }
    }
    
    var chapterContent: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            if let title = viewModel.currentChapter.title {
                HStack {
                    PuraceTextView(title, fontSize: 20, textColor: .white, weight: .medium)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
            }
            if let content = viewModel.currentChapter.content {
                PuraceTextView(content, fontSize: 14, textColor: .white)
                    .multilineTextAlignment(.leading)
            }
        }.padding(.horizontal, 30)
            .padding(.bottom, 60)
    }
    
    var body: some View {
        ZStack {
            tapHandlers
            close
            indicators
            chapterContent
        }.background(
            ZStack(alignment: .center) {
                PuraceImageView(url: URL(string: viewModel.currentChapter.media.link))
                    .aspectRatio(contentMode: .fill)
                LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .center)
            }.ignoresSafeArea(.all)
        )
    }
}
