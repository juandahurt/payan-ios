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
    @StateObject var viewModel: PYStoryViewModel
    
    let onSeenStory: (() -> Void)?
    
    init(viewModel: PYStoryViewModel, onSeenStory: (() -> Void)? = nil) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.onSeenStory = onSeenStory
    }
    
    var close: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .background(
                    Color.black.opacity(0.001)
                        .frame(width: 40, height: 40)
                )
                .onTapGesture {
                    PYRoutingManager.shared.dismiss()
                }
                .padding(.trailing, 30)
        }
    }
    
    var image: some View {
        ZStack {
            PuraceImageView(url: URL(string: viewModel.currentChapter.media.link))
                .aspectRatio(contentMode: .fill)
                .blur(radius: 20)
                .ignoresSafeArea()
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            PuraceImageView(url: URL(string: viewModel.currentChapter.media.link))
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    var indicators: some View {
        HStack(spacing: 3) {
            ForEach(viewModel.chapters.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index < viewModel.currentIndex ? Color.white : Color.white.opacity(0.1))
                    .frame(height: 3)
                    .overlay(
                        Group {
                            if index == viewModel.currentIndex {
                                GeometryReader { reader in
                                    let width = reader.size.width
                                    
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(Color.white)
                                        .frame(width: width * viewModel.currentPercentage)
                                        .animation(.linear(duration: viewModel.timerInterval))
                                }
                            } else {
                                EmptyView()
                            }
                        }
                        
                    )
            }
        }
            .padding(.top, 15)
            .padding(.horizontal, 10)
    }
    
    var topBarBackground: some View {
        VStack {
            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.main.bounds.height * 0.2)
            Spacer()
        }.transition(.opacity)
            .ignoresSafeArea()
    }
    
    var topBar: some View {
        VStack(spacing: 25) {
            if !viewModel.isPaused {
                indicators
                    .opacity(viewModel.chapters.count == 1 ? 0 : 1)
                close
                Spacer()
            }
        }.transition(.opacity)
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
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.3).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                .onChanged { value in
                    switch value {
                        case .second(_, _):
                        withAnimation {
                            viewModel.pause()
                        }
                        default:
                            break
                    }
                }
                .onEnded { value in
                    switch value {
                        case .second(_, _):
                        viewModel.resume()
                        default:
                            break
                    }
                }
        )

    }
    
    var chapterContent: some View {
        Group {
            Spacer()
            if let content = viewModel.currentChapter.content {
                VStack(spacing: 30) {
                    Spacer()
                    if viewModel.chapterContentIsVisible {
                        PuraceTextView(content, fontSize: 10, textColor: .white)
                            .multilineTextAlignment(.center)
                    }
                    PuraceTextView(viewModel.chapterContentIsVisible ? "Ocultar descripción" : "Mostrar descripción", textColor: .white.opacity(0.75), weight: .medium)
                        .onTapGesture {
                            viewModel.chapterContentIsVisible.toggle()
                        }
                }
            }
        }.padding(.horizontal, 30)
            .padding(.bottom, 20)
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 40, height: 40)
    }
    
    var body: some View {
        ZStack {
            topBar
            chapterContent
            if let timer = viewModel.timer {
                EmptyView()
                    .onReceive(timer, perform: { _ in
                        viewModel.timerFired()
                    })
            }
        }
        .background(
            ZStack {
                image
                if !viewModel.isPaused {
                    topBarBackground
                }
                LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .bottom, endPoint: .center)
                    .ignoresSafeArea()
            }
                .overlay(tapHandlers)
        )
            .onReceive(viewModel.storyFinshed) { _ in
                PYRoutingManager.shared.dismiss()
            }
            .onReceive(viewModel.lastChapterSeen) { _ in
                onSeenStory?()
            }
            .onAppear {
                viewModel.resume()
            }
    }
}
