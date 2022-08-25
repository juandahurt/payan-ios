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
    
    func placeCategory(category: PYPlaceCategory) -> some View {
        ZStack {
            PuraceImageView(url: URL(string: category.image))
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height * 0.15)
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
        .cornerRadius(10)
        .contentShape(Rectangle())
        .frame(height: UIScreen.main.bounds.height * 0.15)
        .onTapGesture {
            guard let url = URL(string: category.deeplink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
    }
    
    var placeCategories: some View {
        VStack {
            VStack(spacing: 5) {
                PuraceTextView("Explora lugares", fontSize: 20, textColor: PuraceStyle.Color.N1)
                PuraceTextView("Adentrate en el corazón de la ciudad blanca", fontSize: 14, textColor: PuraceStyle.Color.N4)
            }.padding(.bottom)
            VStack(spacing: 8) {
                ForEach(viewModel.feedData.placeCategories) { category in
                    placeCategory(category: category)
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
        let notSeenIndicatorColor = PuraceStyle.Color.B1
        let seenStory = viewModel.seenStories.contains(where: { $0 == story.hash })
        
        return VStack {
            ZStack {
                if !seenStory {
                    Circle()
                        .fill(.clear)
                        .background(notSeenIndicatorColor.clipShape(Circle()))
                        .clipped()
                        .frame(width: 70, height: 70)
                } else {
                    Circle()
                        .fill(.black.opacity(0.35))
                        .frame(width: 66, height: 66)
                }
                Circle()
                    .fill(Color.white)
                    .frame(width: 65, height: 65)
                PuraceImageView(url: URL(string: story.image))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 58, height: 58)
                    .overlay(
                        Group {
                            if viewModel.loadingStoryIndex == index {
                                ZStack {
                                    Color.white
                                        .opacity(0.5)
                                    ProgressView()
                                }
                            }
                        }
                    )
                    .clipShape(Circle())
                
            }
            PuraceTextView(story.title, fontSize: 10, weight: .medium)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(width: 70)
                .opacity(!seenStory ? 1 : 0.5)
        }
            .onTapGesture {
                guard let url = URL(string: story.link) else { return }
                guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
                guard let idItem = components.queryItems?.first(where: { $0.name == "id" }) else { return }
                viewModel.getStory(id: idItem.value ?? "", index: index)
            }
    }
    
    var stories: some View {
        VStack(spacing: 15) {
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
                VStack {
                    Spacer()
                    
                    loader
                    
                    Spacer()
                }.snackBar(title: viewModel.errorMessage, isVisible: $viewModel.feedErrorOccurred, type: .error, buttonTitle: "REINTENTAR")
                    .onChange(of: viewModel.feedErrorOccurred) { value in
                        if !value {
                            viewModel.getData()
                        }
                    }
            } else {
                ZStack {
                    VStack {
                        navBar
                        ScrollView(showsIndicators: false) {
                            stories
                            VStack(alignment: .leading, spacing: 40) {
                                placeCategories
                                heroes
                            }.padding(.bottom)
                        }
                    }
                    if viewModel.isSearchVisible {
                        PYSearchCoreBuilder().build(isVisible: $viewModel.isSearchVisible)
                    }
                }.transition(.opacity.animation(.linear(duration: 0.2)))
                    .snackBar(title: viewModel.errorMessage, isVisible: $viewModel.storyErrorOccurred, type: .error, duration: .short, dismissOnDrag: true)
                    .offset(x: 0, y: -0.5)
            }
        }
        .background(Color.white)
        .onFirstAppear {
            viewModel.getData()
            viewModel.updateSeenStories()
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.loadingStoryIndex) { newValue in
            if let data = viewModel.storyData, newValue == -1 {
                let vc = PYStoryBuilder().build(data: data, onSeenStory: {
                    viewModel.saveSeenStory(hash: viewModel.storyData?.hash ?? "")
                })
                PYRoutingManager.shared.present(vc)
            }
        }
    }
}


// TODO: remove!!
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
