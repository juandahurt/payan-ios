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
    
    var title: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                PuraceTextView(viewModel.hero.name, fontSize: 25, weight: .semibold)
                    .multilineTextAlignment(.leading)
                
                PuraceTextView(viewModel.dates, textColor: PuraceStyle.Color.N4)
                    .multilineTextAlignment(.leading)
            }
            Spacer(minLength: 0)
        }
    }
    
    var image: some View {
            PuraceImageView(url: URL(string: viewModel.hero.image))
                .scaledToFit()
                .animation(.none)
                .frame(height: UIScreen.main.bounds.height * 0.35)
                .cornerRadius(5)
                .onTapGesture {
                    withAnimation {
                        viewModel.showImageViewer()
                    }
                }
    }
    
    var description: some View {
        HStack(spacing: 0) {
            PuraceTextView(viewModel.hero.description)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 0)
        }
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
            .background(Color.white)
            .cornerRadius(10)
    }
    
    var loader: some View {
        VStack {
            Spacer()
            
            PuraceCircularLoaderView()
                .frame(width: 80, height: 80)
            
            Spacer()
        }
    }
    
    var header: some View {
        VStack(spacing: 25) {
            image
            title
            description
        }
    }
    
    var body: some View {
        PuraceScaffold(navBar: .init(title: "", backOnTap: {
            PYRoutingManager.shared.pop()
        })) {
            PuraceScaffoldContent {
                Group {
                    if viewModel.isLoading {
                        loader
                    } else {
                        ScrollView {
                            VStack(alignment: .center, spacing: 25) {
                                header
                                sections
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            .padding(.top, 30)
                        }
                    }
                }
            }.genericErrorView(isPresented: $viewModel.errorHasOccured) {
                viewModel.getHero(id: heroId)
            }
        }
        .background(PuraceStyle.Color.F1)
            .onFirstAppear {
                viewModel.getHero(id: heroId)
            }
            .onChange(of: viewModel.errorHasOccured) { value in
                if !value {
                    viewModel.getHero(id: heroId)
                }
            }
            .imageViewer(
                urls: [URL(string: viewModel.hero.image)],
                isVisible: $viewModel.isImageViewerVisible
            )
            .onAppear {
                AnalyticsManager.shared.trackView(path: "/hero", params: ["heroId": heroId])
            }
    }
}
