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
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 15) {
                    PuraceLogoLoaderView(percentage: $viewModel.loadedPercentage)
                        .frame(width: 45, height: 70)
                    PuraceTextView("Llegando a Popayán...")
                }
            } else {
                ScrollView {
                    VStack(spacing: 5) {
                        PuraceTextView("Explora lugares", fontSize: 20, textColor: PuraceStyle.Color.N1)
                        PuraceTextView("Adentrate en el corazón de la ciudad blanca", fontSize: 14, textColor: PuraceStyle.Color.N4)
                    }.padding(.bottom, 5)
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
        }
        .background(Color.white)
        .onAppear {
            viewModel.getData()
        }
    }
}
