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
    @EnvironmentObject var store: AppStore<PYFeedState, PYFeedAction, String>
    
    // MARK: - Place categories section
    var placeCategoriesSection: some View {
        let header = PYFeedSectionHeader(
            isLoading: $store.state.isLoading,
            title: "Explora lugares",
            subtitle: "Adentrate en el corazón de la ciudad blanca").padding(.horizontal, 16
        )
        return PYFeedSection(header: header) {
            Group {
                if !store.state.placeCategories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(store.state.placeCategories.indices, id: \.self) { categoryIndex in
                                let category = store.state.placeCategories[categoryIndex]
                                PYFeedPlaceCategory(
                                    link: category.deeplink,
                                    image: category.image,
                                    title: category.title,
                                    numberOfPlaces: category.numberOfPlaces
                                ).padding(.leading, categoryIndex == 0 ? 16 : 0)
                                    .padding(.trailing, categoryIndex == store.state.placeCategories.count - 1 ? 16 : 0)
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: - Search Field
    var searchField: some View {
        HStack {
            PuraceTextView("Buscar...", textColor: PuraceStyle.Color.N4)
                .padding(.leading)
            Spacer()
            Image("search-alt")
                .resizable()
                .scaledToFit()
                .frame(width: 25)
                .padding(.trailing)
        }
        .frame(height: 45)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(PuraceStyle.Color.N8, lineWidth: 2)
        )
        .background(Color.black.opacity(0.03))
        .cornerRadius(20)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Heroes section
//    var heroesSection: some View {
//        let header = PYFeedSectionHeader(title: "Próceres", buttonTitile: "Ver todos") {
//            let builder = PYCollectionBuilder()
//            let typeItem = URLQueryItem(name: "type", value: "hero")
//            if let vc = builder.build(params: [typeItem]) {
//                PYRoutingManager.shared.push(vc)
//            }
//        }
//        return PYFeedSection(header: header) {
//            VStack(spacing: 10) {
//                ForEach(viewModel.feedData.heroes.indices, id: \.self) { heroIndex in
//                    let hero = viewModel.feedData.heroes[heroIndex]
//                    PYFeedHero(
//                        image: hero.image,
//                        title: hero.name,
//                        subtitle: hero.description
//                    ) {
//                        guard let url = URL(string: hero.deepLink) else { return }
//                        PYRoutingManager.shared.open(url: url)
//                    }
//                }
//            }
//        }.padding(.horizontal, 16)
//    }
    
    var title: some View {
        HStack {
            PuraceTextView("Buenos días.", fontSize: 16, weight: .medium)
                .skeleton(with: store.state.isLoading, transition: .opacity)
                .multiline(lines: 1, scales: [0: 0.3])
                .frame(height: 20)
            
            Spacer()
        }.padding([.top, .horizontal], 16)
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 50, height: 50)
    }
    
//    func storyPreview(at index: Int) -> some View {
//        let story = viewModel.stories[index]
//        let seenStory = viewModel.seenStories.contains(where: { $0 == story.hash })
//
//        return PYFeedStoryPreview(title: story.title, seenStory: seenStory, image: story.image, isLoading: index == viewModel.loadingStoryIndex) {
//                guard let url = URL(string: story.link) else { return }
//                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
//                guard let idItem = components.queryItems?.first(where: { $0.name == "id" }) else { return }
//                viewModel.getStory(id: idItem.value ?? "", index: index)
//            }
//    }
    
    // MARK: - Stories section
//    var storiesSection: some View {
//        let header = PYFeedSectionHeader(title: "Historias", subtitle: "Conoce un poco de la historia de la ciudad")
//        return PYFeedSection(header: header) {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(viewModel.stories.indices, id: \.self) { index in
//                        storyPreview(at: index)
//                    }
//                }
//            }
//        }.padding(.horizontal, 16)
//    }
    
    var body: some View {
        Group {
            ScrollView {
                VStack(spacing: 30) {
                    title
                    searchField
                    placeCategoriesSection
//                        storiesSection
//                        heroesSection
                }
            }
        }
            .onAppear {
//                viewModel.getData()
                store.send(.getData)
            }
    }
//        Group {
//            if viewModel.isLoading {
//                VStack {
//                    Spacer()
//
//                    loader
//
//                    Spacer()
//                }.snackBar(title: viewModel.errorMessage, isVisible: $viewModel.feedErrorOccurred, type: .error, buttonTitle: "REINTENTAR")
//                    .onChange(of: viewModel.feedErrorOccurred) { value in
//                        if !value {
//                            viewModel.getData()
//                        }
//                    }
//            } else {
//                ZStack {
//                    VStack {
//                        navBar
//                        ScrollView(showsIndicators: false) {
//                            VStack(alignment: .leading, spacing: 40) {
//                                stories
//                                placeCategories
//                                heroes
//                            }.padding(.bottom)
//                        }
//                    }.onAppear {
//                        AnalyticsManager.shared.trackView(path: "/feed", params: nil)
//                    }
//                    if viewModel.isSearchVisible {
//                        PYSearchCoreBuilder().build(isVisible: $viewModel.isSearchVisible)
//                    }
//                }
//                    .snackBar(title: viewModel.errorMessage, isVisible: $viewModel.storyErrorOccurred, type: .error, duration: .short, dismissOnDrag: true)
//                    .offset(x: 0, y: -0.5) // workaround to show the snackbar. :c
//                    .transition(.opacity.animation(.linear(duration: 0.2)))
//            }
//        }
//        .background(Color.white)
//        .onFirstAppear {
//            viewModel.getData()
//            viewModel.updateSeenStories()
//        }
//        .navigationBarHidden(true)
//        .onChange(of: viewModel.loadingStoryIndex) { newValue in
//            if let data = viewModel.storyData, newValue == -1 {
//                let vc = PYStoryBuilder().build(data: data, onSeenStory: {
//                    viewModel.saveSeenStory(hash: viewModel.storyData?.hash ?? "")
//                })
//                PYRoutingManager.shared.present(vc)
//            }
//        }
//        .ignoresSafeArea(.keyboard)
//    }
}
