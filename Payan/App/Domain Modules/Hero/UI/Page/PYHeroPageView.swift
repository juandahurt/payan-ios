//
//  PYHeroPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 13/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYHeroPageView: View, PYHeroViewLogic {
    @StateObject var viewModel: PYHeroViewModel
    
    var heroId: String
    
    init(heroId: String, viewModel: PYHeroViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.heroId = heroId
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            VStack(spacing: 0) {
                Spacer()
                Image(systemName: "chevron.left")
                    .foregroundColor(PuraceStyle.Color.N1)
                    .scaleEffect(1.2)
                    .padding()
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        PYRoutingManager.shared.pop()
                    }
            }
            Spacer()
        }
            .frame(height: 50)
    }
    
    var title: some View {
        VStack(spacing: viewModel.isLoading ? 15 : 10) {
            HStack {
                Spacer(minLength: viewModel.isLoading ? UIScreen.main.bounds.width * 0.2 : 0)
                PuraceTextView(viewModel.hero.name, fontSize: 22, weight: .medium)
                    .skeleton(with: viewModel.isLoading)
                    .multiline(lines: 1)
                Spacer(minLength: viewModel.isLoading ? UIScreen.main.bounds.width * 0.2 : 0)
            }
            HStack {
                Spacer(minLength: viewModel.isLoading ? UIScreen.main.bounds.width * 0.35 : 0)
                PuraceTextView(viewModel.dates, fontSize: 14, textColor: PuraceStyle.Color.N4)
                    .skeleton(with: viewModel.isLoading)
                    .multiline(lines: 1)
                Spacer(minLength: viewModel.isLoading ? UIScreen.main.bounds.width * 0.35 : 0)
            }
        }
            .padding(.vertical, viewModel.isLoading ? 10 : 0)
    }
    
    var image: some View {
        ZStack {
            PuraceStyle.Color.G1.opacity(0.05)
            PuraceImageView(url: URL(string: viewModel.hero.image))
                .scaledToFit()
                .animation(.none)
        }
            .skeleton(with: viewModel.isLoading)
            .shape(type: .rectangle)
            .frame(height: UIScreen.main.bounds.height * 0.35)
            .onTapGesture {
                viewModel.showImageViewer()
            }
    }
    
    var description: some View {
        HStack(spacing: 0) {
            PuraceTextView(viewModel.hero.description)
                .multilineTextAlignment(.leading)
                .skeleton(with: viewModel.isLoading)
                .multiline(lines: 4, scales: [1: 0.9, 3: 0.6])
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 30)
    }
    
    var sections: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.hero.sections.indices, id: \.self) { index in
                PuraceAccordionView(title: viewModel.section(at: index).title) {
                    HStack(spacing: 0) {
                        PuraceTextView(viewModel.section(at: index).content)
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 0)
                    }.padding(.vertical)
                        .padding(.horizontal, 30)
                }
            }
        }.opacity(viewModel.isLoading ? 0 : 1)
    }
    
    var body: some View {
        VStack {
            navBar
            ScrollView {
                VStack(spacing: 40) {
                    image
                    title
                    description
                    sections
                }
            }
            Spacer()
        }
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getHero(id: heroId)
            }
            .snackBar(title: "Parece que ha habido un error", isVisible: $viewModel.errorHasOccured, type: .error, buttonTitle: "REINTENTAR")
            .onChange(of: viewModel.errorHasOccured) { value in
                if !value {
                    viewModel.getHero(id: heroId)
                }
            }
            .imageViewer(
                urls: [URL(string: viewModel.hero.image)],
                isVisible: $viewModel.isImageViewerVisible
            )
    }
}
