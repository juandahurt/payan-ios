//
//  PYFeedPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 20/05/22.
//

import PYLayout
import Kingfisher
import SwiftUI

struct PYFeedPageView: View {
    @StateObject var viewModel = PYFeedViewModel()
    
    var body: some View {
        ScrollView {
            PYTextView("Explora lugares", fontSize: 20)
            PYTextView("Adentrate en el corazón de la ciudad blanca")
            PYVerticalGridView(columns: 1, spacing: 5) {
                if !viewModel.feedData.placeCategories.isEmpty {
                    ForEach(viewModel.feedData.placeCategories.indices) { index in
                        let category = viewModel.feedData.placeCategories[index]
                        ZStack {
                            KFImage.url(URL(string: category.image))
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 135)
                            Color.black
                                .opacity(0.35)
                            VStack(spacing: 5) {
                                PYTextView(category.title, fontSize: 14, textColor: .white, weight: .medium)
                                PYTextView("\(category.numberOfPlaces) lugares", textColor: .white)
                            }
                        }.cornerRadius(5)
                    }
                }
            }.padding(.horizontal, 16)
        }
        .background(Color.white)
        .onAppear {
            viewModel.getData()
        }
    }
}
