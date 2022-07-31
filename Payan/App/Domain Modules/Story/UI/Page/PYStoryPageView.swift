//
//  PYStoryPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Foundation
import SwiftUI
import Purace

struct PYStoryPageView: View, PYStoryViewLogic {
    @StateObject var viewModel: PYStoryViewModel
    var id: String
    
    init(id: String, viewModel: PYStoryViewModel) {
        self.id = id
        self._viewModel = .init(wrappedValue: viewModel)
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
    }
    
    var topBar: some View {
        VStack(spacing: 25) {
            if !viewModel.isPaused {
                if viewModel.chapters.count > 1 {
                    indicators
                }
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
                HStack {
                    PuraceTextView(content, fontSize: 14, textColor: .white)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
            }
        }.padding(.horizontal, 30)
            .padding(.bottom, 20)
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 40, height: 40)
            .transition(.opacity.animation(.linear))
    }
    
    var body: some View {
        ZStack {
            topBar
            if !viewModel.isLoading {
                chapterContent
            }
            if let timer = viewModel.timer {
                EmptyView()
                    .onReceive(timer, perform: { _ in
                        viewModel.timerFired()
                    })
            }
        }
        .background(
            ZStack {
                PuraceImageView(url: URL(string: viewModel.currentChapter.media.link))
                    .aspectRatio(contentMode: .fill)
                if !viewModel.isPaused {
                    topBarBackground
                }
                LinearGradient(colors: [.black.opacity(0.6), .clear], startPoint: .bottom, endPoint: .center)
                    .skeleton(with: viewModel.isLoading)
                    .shape(type: .rectangle)
            }
                .ignoresSafeArea()
                .overlay(tapHandlers)
        )
            .onAppear {
                viewModel.getData(id: id)
            }
            .snackBar(title: "Parece que ha habido un error", isVisible: $viewModel.errorHasOccurred, type: .error, buttonTitle: "REINTENTAR")
            .onChange(of: viewModel.errorHasOccurred) { value in
                if !value {
                    viewModel.getData(id: id)
                }
            }
            .onReceive(viewModel.storyFinshed) { _ in
                PYRoutingManager.shared.dismiss()
            }
    }
}
