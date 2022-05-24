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
    @StateObject var viewModel = PYFeedViewModel()
    
    var placeCategories: some View {
        VStack {
            VStack(spacing: 5) {
                PuraceTextView("Explora lugares", fontSize: 20, textColor: PuraceStyle.Color.N1)
                PuraceTextView("Adentrate en el corazón de la ciudad blanca", fontSize: 14, textColor: PuraceStyle.Color.N4)
            }.padding(.bottom)
            PuraceVerticalGridView(columns: 1, spacing: 5) {
                if !viewModel.feedData.placeCategories.isEmpty {
                    ForEach(viewModel.feedData.placeCategories.indices) { index in
                        let category = viewModel.feedData.placeCategories[index]
                        ZStack {
                            PuraceImageView(url: URL(string: category.image))
                                .scaledToFill()
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 135)
                            Color.black
                                .opacity(0.35)
                            VStack(spacing: 5) {
                                PuraceTextView(category.title, fontSize: 14, textColor: .white, weight: .medium)
                                PuraceTextView("\(category.numberOfPlaces) lugares", textColor: .white)
                            }
                        }.cornerRadius(5)
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
            PuraceCollectionCardView(cards: [
                MockCard("https://www.biografiasyvidas.com/biografia/c/fotos/caldas_francisco_jose_2.jpg"),
                MockCard("https://upload.wikimedia.org/wikipedia/commons/a/ac/Froil%C3%A1n_Largacha_Hurtado.jpg"),
                MockCard("https://upload.wikimedia.org/wikipedia/commons/8/86/Camilo_Torres_y_Tenorio.jpg")
            ]).padding(.bottom)
            PuraceButtonView("Ver todos", fontSize: 14, type: .quiet)
        }
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 15) {
                    PuraceLogoLoaderView(percentage: $viewModel.loadedPercentage)
                        .frame(width: 45, height: 70)
                    PuraceTextView("Llegando a Popayán...")
                }
            } else {
                ZStack {
                    ScrollView {
                        VStack(spacing: 40) {
                            placeCategories
                            heroes
                        }
                    }
                    VStack {
                        Spacer()
                        PuraceSnackbarView(
                            title: "Bienvenido",
                            type: .info,
                            isVisible: $viewModel.snackbarIsVisible
                        )
                    }
                }
                
            }
        }
        .background(Color.white)
        .onAppear {
            viewModel.getData()
        }
    }
}

struct MockCard: PuraceCollectionCardData {
    var deepLink: String = ""
    var backgroundImage: URL?
    var title: String = "Froilán Largacha Hurtado"
    
    init(_ url: String) {
        self.backgroundImage = URL(string: url)
    }
}
