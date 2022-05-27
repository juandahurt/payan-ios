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
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
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
            ScrollView {
                PuraceTextView(viewModel.collection.title, fontSize: 22)
                    .padding(.bottom, 20)
                PuraceVerticalGridView(columns: 1, spacing: 2) {
                    ForEach(viewModel.collection.elements) { element in
                        PuraceImageView(url: URL(string: element.image))
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.height * 0.2)
                            .clipped()
                    }
                }
            }
        }.navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getCollection(ofType: type, categoryId: categoryId)
            }
    }
}
