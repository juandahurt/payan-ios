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
                            PuraceTextView(category.title, textColor: .white, weight: .medium)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 15)
                                .background (
                                    ZStack {
                                        Color.black.opacity(0.2)
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.white, lineWidth: 1)
                                    }
                                )
                        }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                PuraceTextView("\(category.numberOfPlaces) lugares", fontSize: 10, textColor: .white)
                                    .frame(alignment: .bottomTrailing)
                                    .padding()
                            }
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
        HStack(alignment: .center) {
            PuraceTextView("Payán", weight: .medium)
            Spacer()
            Image("search")
                .onTapGesture {
                    viewModel.showSearch()
                }
        }
            .padding(.vertical, 11)
            .background(Color.white)
            .padding(.horizontal, 16)
    }
    
    func storyPreview(at index: Int) -> some View {
        let story = viewModel.stories[index]
        let notSeenIndicatorColor = LinearGradient(colors: [.blue, .red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
        
        return VStack {
            ZStack {
                if index == 0 {
                    Circle()
                        .fill(.clear)
                        .background(notSeenIndicatorColor.clipShape(Circle()))
                        .clipped()
                        .frame(width: 65, height: 65)
                } else {
                    Circle()
                        .fill(PuraceStyle.Color.N5)
                        .frame(width: 62, height: 62)
                }
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                PuraceImageView(url: URL(string: story.image))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 53, height: 53)
            }
            PuraceTextView(story.title, weight: .regular)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(width: 80)
                .opacity(index == 0 ? 1 : 0.5)
        }
            .onTapGesture {
                guard let url = URL(string: story.link) else { return }
                PYRoutingManager.shared.open(url: url)
            }
    }
    
    var stories: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.stories.indices, id: \.self) { index in
                        storyPreview(at: index)
                    }
                }.padding(.horizontal, 16)
            }
            Divider()
                .opacity(0.5)
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
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 40) {
                                stories
                                placeCategories
                                heroes
                            }.padding(.bottom)
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
