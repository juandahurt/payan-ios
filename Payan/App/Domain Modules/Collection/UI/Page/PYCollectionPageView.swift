//
//  PYCollectionPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 26/05/22.
//

import Foundation
import SkeletonUI
import SwiftUI
import Purace

struct PYCollectionPageView: View, PYCollectionViewLogic {
    var type: String
    var categoryId: String?
    
    @StateObject var viewModel = PYCollectionViewModel()
    @State var title = ""
    
    let heroHeight = UIScreen.main.bounds.width * 0.8
    let placeHeight = UIScreen.main.bounds.height * 0.2
    let correctHeight: CGFloat
    let correctItemWidth: CGFloat
    let columns: Int
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
        correctHeight = type == "hero" ? heroHeight : placeHeight
        columns = type == "hero" ? 2 : 1
        correctItemWidth = type == "hero" ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .onTapGesture {
                    PYRoutingManager.shared.pop()
                }
            Spacer()
            PuraceTextView(title, fontSize: 16, weight: .medium)
            Spacer()
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .opacity(0)
        }.padding()
            .frame(height: 50)
    }
    
    func collectionElement(_ element: PYCollectionElement) -> some View {
        PuraceImageView(url: URL(string: element.image)) {
            Color.black.opacity(0.20)
            Group {
                PuraceTextView(element.title, fontSize: 12, textColor: .white, weight: .medium)
                    .multilineTextAlignment(.center)
                    .cornerRadius(5)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background (
                        ZStack {
                            Color.black.opacity(0.2)
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.white, lineWidth: 1)
                        }
                    )
                    .frame(maxWidth: correctItemWidth * 0.8)
            }
        }
        .animation(.none)
        .skeleton(with: viewModel.isLoading, transition: .opacity)
        .shape(type: .rectangle)
        .aspectRatio(contentMode: .fill)
        .frame(width: UIScreen.main.bounds.width / CGFloat(columns), height: correctHeight)
        .clipped()
        .contentShape(Rectangle())
        .onTapGesture {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
    }
    
    var collection: some View {
        OffsettableScrollView { value in
            if value.y < -70 {
                title = viewModel.collection.title
            } else {
                title = ""
            }
        } content: {
            PuraceTextView(viewModel.collection.title, fontSize: 22)
                .padding(.bottom, 20)
                .frame(height: 70)
            PuraceVerticalGridView(columns: columns, spacing: 2) {
                ForEach(viewModel.collection.elements) { element in
                    collectionElement(element)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            navBar
            collection
        }.navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getCollection(ofType: type, categoryId: categoryId)
            }
    }
}
