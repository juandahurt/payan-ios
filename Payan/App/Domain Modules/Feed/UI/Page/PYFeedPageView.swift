//
//  PYFeedPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 20/05/22.
//

import Purace
import Kingfisher
import SwiftUI

struct PYFeedPageView: View {
    @StateObject var viewModel: PYFeedViewModel
    
    init(viewModel: PYFeedViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var placeCategories: some View {
        VStack {
            VStack(spacing: 5) {
                PuraceTextView("Explora lugares", fontSize: 20, textColor: PuraceStyle.Color.N1)
                PuraceTextView("Adentrate en el corazón de la ciudad blanca", fontSize: 14, textColor: PuraceStyle.Color.N4)
            }.padding(.bottom)
            PuraceVerticalGridView(columns: 1, spacing: 5) {
                ForEach(viewModel.feedData.placeCategories) { category in
                    ZStack {
                        PuraceImageView(url: URL(string: category.image))
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 135)
                            .clipped()
                        Color.black
                            .opacity(0.35)
                        VStack(spacing: 5) {
                            PuraceTextView(category.title, fontSize: 14, textColor: .white, weight: .medium)
                            PuraceTextView("\(category.numberOfPlaces) lugares", textColor: .white)
                        }
                    }
                    .cornerRadius(5)
                    .contentShape(Rectangle())
                    .frame(height: 135)
                    .onTapGesture {
                        guard let url = URL(string: category.deeplink) else { return }
                        PYRoutingManager.shared.open(url: url)
                    }
                        
                }
            }.padding(.horizontal, 16)
        }
    }
    
    var heroes: some View {
        VStack {
            VStack(spacing: 5) {
                PuraceTextView("Próceres", fontSize: 20, textColor: PuraceStyle.Color.N1)
                PuraceTextView("Algunos personajes ilustres de la ciudad", fontSize: 14, textColor: PuraceStyle.Color.N4)
            }.padding(.bottom)
            PuraceCollectionCardView(
                firstCardSize: .init(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.92),
                cards: viewModel.feedData.heroes
            ) { selectedCard in
                if let hero = viewModel.feedData.heroes.first(where: { $0.title == selectedCard.title }) {
                    guard let url = URL(string: hero.deepLink) else { return }
                    PYRoutingManager.shared.open(url: url)
                }
            }
                .frame(height: UIScreen.main.bounds.width * 0.9)
                .padding(.bottom, 25)
            PuraceButtonView("Ver todos", fontSize: 14) {
                guard let url = URL(string: "payan://collection?type=hero") else { return }
                PYRoutingManager.shared.open(url: url)
            }
        }
    }
    
    var loader: some View {
        VStack(spacing: 15) {
            PuraceLogoLoaderView(percentage: $viewModel.loadedPercentage)
                .frame(width: 45, height: 70)
            PuraceTextView(viewModel.errorOccurred ? "No pudimos llegar." : "Llegando a Popayán...")
        }.offset(x: 0, y: 9)
            .transition(.opacity.animation(.linear(duration: 0.2)))
    }
    
    var navBar: some View {
        HStack {
            Image("search")
                .padding(.horizontal, 16)
                .onTapGesture {
                    viewModel.showSearch()
                }
                .opacity(viewModel.isNavBarVisible ? 1 : 0)
            Spacer()
                .frame(height: 40)
        }.background(Color.white)
    }
    
    var storyPreview: some View {
        ZStack {
            PuraceImageView(url: URL(string: "https://cdn.colombia.com/sdi/2019/03/31/a-36-anos-del-terremoto-de-popayan-723989.jpg"))
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.height * 0.2, height: UIScreen.main.bounds.height * 0.35)
            Color.black.opacity(0.2)
            PuraceTextView("El terremoto de 1983", textColor: .white, weight: .medium)
            VStack(spacing: 8) {
                Spacer()
                Color.white
                    .frame(width: 66, height: 2)
            }.padding(.bottom)
        }
            .frame(width: UIScreen.main.bounds.height * 0.2, height: UIScreen.main.bounds.height * 0.35)
            .onTapGesture {
                PYRoutingManager.shared.open(url: URL(string: "payan://story?id=123")!)
            }
            .clipped()
            .contentShape(Rectangle())
    }
    
    var stories: some View {
        VStack {
            VStack(spacing: 5) {
                PuraceTextView("¿Sabías esto?", fontSize: 20, textColor: PuraceStyle.Color.N1)
                PuraceTextView("Conoce la ciudad a través de pequeñas histórias", fontSize: 14, textColor: PuraceStyle.Color.N4)
            }.padding(.bottom)
            
            ScrollView(.horizontal) {
                HStack {
                    storyPreview
                }.padding(.horizontal, 16)
            }
        }
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                loader
            } else {
                ZStack {
                    VStack {
                        navBar
                            .frame(height: viewModel.isNavBarVisible ? 40 : 0)
                        OffsettableScrollView { value in
                            withAnimation {
                                viewModel.tryToUpdateNavBar(currentOffset: value)
                            }
                        } content: {
                            VStack(spacing: 40) {
                                placeCategories
                                stories
                                heroes
                            }.padding(.vertical)
                        }
                    }
                    if viewModel.isSearchVisible {
                        PYSearchCoreBuilder().build(isVisible: $viewModel.isSearchVisible)
                    }
                }.transition(.opacity.animation(.linear(duration: 0.2)))
            }
        }
        .background(Color.white)
        .onFirstAppear {
            viewModel.getData()
        }
        .navigationBarHidden(true)
        .snackBar(title: "Parece que ha ocurrido un error", isVisible: $viewModel.errorOccurred, type: .error, buttonTitle: "REINTENTAR")
        .onChange(of: viewModel.errorOccurred) { value in
            if !value {
                viewModel.getData()
            }
        }
    }
}

extension PYHeroPreview: PuraceCollectionCardData {
    var backgroundImage: URL? {
        URL(string: image)
    }
    var title: String {
        name
    }
    var subtitle: String {
        description
    }
}
