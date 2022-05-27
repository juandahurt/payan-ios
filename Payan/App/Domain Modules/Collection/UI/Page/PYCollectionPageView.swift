//
//  PYCollectionPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 26/05/22.
//

import Foundation
import SwiftUI
import Purace

struct PYCollectionPageView: View, PYCollectionViewLogic {
    var type: String
    var categoryId: String?
    
    @StateObject var viewModel = PYCollectionViewModel()
    
    let heroHeight = UIScreen.main.bounds.width * 0.8
    let placeHeight = UIScreen.main.bounds.height * 0.2
    let correctHeight: CGFloat
    let columns: Int
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
        correctHeight = type == "hero" ? heroHeight : placeHeight
        columns = type == "hero" ? 2 : 1
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "chevron.left")
                    .foregroundColor(PuraceStyle.Color.N1)
                    .scaleEffect(1.2)
                    .onTapGesture {
                        PYRoutingManager.shared.pop()
                    }
                Spacer()
            }.padding()
                .frame(height: 50)
            ScrollView {
                PuraceTextView(viewModel.collection.title, fontSize: 22)
                    .padding(.bottom, 20)
                PuraceVerticalGridView(columns: columns, spacing: 2) {
                    ForEach(viewModel.collection.elements) { element in
                        ZStack {
                            PuraceImageView(url: URL(string: element.image))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / CGFloat(columns), height: correctHeight)
                                .clipped()
                            LinearGradient(colors: [.black.opacity(0.55), .clear], startPoint: .bottom, endPoint: .center)
                            VStack(alignment: .center) {
                                Spacer()
                                PuraceTextView(element.title, fontSize: 14, textColor: .white, weight: .medium)
                                    .multilineTextAlignment(.center)
                            }.padding()
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getCollection(ofType: type, categoryId: categoryId)
            }
    }
}
