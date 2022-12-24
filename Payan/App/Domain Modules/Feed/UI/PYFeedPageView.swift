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
    @EnvironmentObject var store: AppStore<PYFeedState, PYFeedAction>
    
    // MARK: - Place categories section
    var placeCategoriesSection: some View {
        let header = PYFeedSectionHeader(
            showSkeleton: $store.state.isLoading,
            title: "Explora lugares"
        )
                .padding(.horizontal, 16)
        return PYFeedSection(header: header) {
            Group {
                if !store.state.placeCategories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(store.state.placeCategories.indices, id: \.self) { categoryIndex in
                                let category = store.state.placeCategories[categoryIndex]
                                PYFeedPlaceCategory(
                                    showSkeleton: $store.state.isLoading,
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
        .skeleton(with: store.state.isLoading)
        .shape(type: .rounded(.radius(20, style: .circular)))
        .frame(height: 45)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(PuraceStyle.Color.N8, lineWidth: 2)
        )
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .onTapGesture {
            let vc = PYSearchCoreBuilder().build()
            PYRoutingManager.shared.push(vc, animated: false)
        }
    }
    
    // MARK: - Heroes section
    var heroesSection: some View {
        let header = PYFeedSectionHeader(
            showSkeleton: $store.state.isLoading,
            title: "Próceres",
            buttonTitle: "Ver todos")
        {
            let builder = PYCollectionBuilder()
            let typeItem = URLQueryItem(name: "type", value: "hero")
            if let vc = builder.build(params: [typeItem]) {
                PYRoutingManager.shared.push(vc)
            }
        }
        return PYFeedSection(header: header) {
            VStack(spacing: 10) {
                ForEach(store.state.heroes.indices, id: \.self) { heroIndex in
                    let hero = store.state.heroes[heroIndex]
                    PYFeedHero(
                        showSkeleton: $store.state.isLoading,
                        image: hero.image,
                        title: hero.name,
                        subtitle: hero.description
                    ) {
                        guard let url = URL(string: hero.deepLink) else { return }
                        PYRoutingManager.shared.open(url: url)
                    }
                }
            }
        }.padding(.horizontal, 16)
    }
    
    // TODO: set title based on device time
    var title: some View {
        HStack {
            PuraceTextView("Buenos días.", fontSize: 16, weight: .medium)
                .frame(height: 20)
            
            Spacer()
        }.padding([.top, .horizontal], 16)
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 50, height: 50)
    }
    
    // MARK: - Stories section
    var storiesSection: some View {
        let header = PYFeedSectionHeader(
            showSkeleton: $store.state.isLoading,
            title: "Historias"
        )
        return PYFeedSection(header: header) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(store.state.stories.indices, id: \.self) { index in
                        let story = store.state.stories[index]
                //        let seenStory = store.state.seenStories.contains(where: { $0 == story.hash })
                        PYFeedStoryPreview(
                            showSkeleton: $store.state.isLoading,
                            title: story.title,
                            seenStory: true,
                            image: story.image,
                            isLoading: store.state.loadingStoryIndex == index
                        ) {
                            //                viewModel.getStory(id: idItem.value ?? "", index: index)
                            store.send(.loadStory(id: story.id, index: index))
                        }
                    }
                }
            }
        }.padding(.horizontal, 16)
    }
    
    var body: some View {
        PuraceScaffold(navBar: nil) {
            PuraceScaffoldContent {
                VStack(spacing: 0) {
                    Color.white.frame(height: 1) // to prevent scroll from going off the top
                    ScrollView {
                        VStack(spacing: 35) {
                            title
                            searchField
                            placeCategoriesSection
                            storiesSection
                            heroesSection
                        }.padding(.bottom, 16)
                    }.allowsHitTesting(!store.state.isLoading)
                }
            }.genericErrorView(isPresented: $store.state.feedErrorOccured) {
                store.send(.getData)
            }
        }
            .background(
                ZStack {
                    PuraceStyle.Color.F1
                    
                    VStack {
                        LinearGradient(colors: [.white, PuraceStyle.Color.F1], startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                        Spacer()
                    }
                }
            )
            .onFirstAppear {
                store.send(.getData)
            }
            .onChange(of: store.state.storyToBeShown) { data in
                guard let data else { return }
                let vc = PYStoryBuilder().build(data: data) {
                    // TODO: save seen story
                    #warning("TODO: save seen story")
                }
                PYRoutingManager.shared.present(vc)
            }
            .onChange(of: store.state.storyErrorOccured) { errorOccured in
                if errorOccured {
                    PuraceSnackbarBuilder()
                        .withTitle(PYFeedConstants.Wordings.storyErrorMessage)
                        .withType(.error)
                        .build()
                        .show()
                }
            }
            .onAppear {
                AnalyticsManager.shared.trackView(path: PYFeedConstants.Analytics.pageName, params: nil)
            }
    }
}
