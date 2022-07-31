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
                    .fill(index <= viewModel.currentIndex ? Color.white : Color.white.opacity(0.1))
                    .frame(height: 3)
            }
        }
            .padding(.top, 15)
            .padding(.horizontal, 10)
    }
    
    var topBar: some View {
        VStack(spacing: 25) {
            if viewModel.chapters.count > 1 {
                indicators
            }
            close
            Spacer()
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
            tapHandlers
            topBar
            if !viewModel.isLoading {
                chapterContent
            }
        }.background(
            ZStack {
                PuraceImageView(url: URL(string: viewModel.currentChapter.media.link))
                    .aspectRatio(contentMode: .fill)
                VStack {
                    LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
                        .frame(height: UIScreen.main.bounds.height * 0.2)
                    Spacer()
                }
                LinearGradient(colors: [.black.opacity(0.8), .clear], startPoint: .bottom, endPoint: .center)
                    .skeleton(with: viewModel.isLoading)
                    .shape(type: .rectangle)
            }
                .ignoresSafeArea()
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
    }
}
