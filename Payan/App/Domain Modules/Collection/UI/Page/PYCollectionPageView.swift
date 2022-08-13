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
    let correctHeight: CGFloat
    let correctItemWidth: CGFloat
    let columns: Int
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
        columns = type == "hero" ? 2 : 3
        correctItemWidth = UIScreen.main.bounds.width / CGFloat(columns)
        correctHeight = type == "hero" ? heroHeight : correctItemWidth
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .padding()
                .background(Color.black.opacity(0.001))
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
                .padding()
        }
            .frame(height: 50)
    }
    
    func placeElement(_ element: PYCollectionElement, index: Int) -> some View {
        ZStack {
            PuraceImageView(url: URL(string: element.image))
                .aspectRatio(contentMode: .fill)
                .frame(width: correctItemWidth, height: correctHeight)
                .clipped()
            Color.black.opacity(0.2)
            VStack {
                Spacer()
                HStack {
                    PuraceTextView(element.title, fontSize: 10, textColor: .white, weight: .medium)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .padding(8)
                    Spacer(minLength: 0)
                }
            }
        }
        .frame(width: correctItemWidth, height: correctHeight)
        .contentShape(Rectangle())
        .onTapGesture {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
        .transition(.opacity.animation(.spring().delay(Double(index) * 0.15)))
    }
    
    func heroElement(_ element: PYCollectionElement, index: Int) -> some View {
        ZStack {
            PuraceImageView(url: URL(string: element.image))
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / CGFloat(columns), height: correctHeight)
                .clipped()
            Color.black.opacity(0.20)
            PuraceTextView(element.title, fontSize: 12, textColor: .white, weight: .medium)
                .multilineTextAlignment(.center)
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
                .background (
                    ZStack {
                        Color.black.opacity(0.2)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1.1)
                    }
                )
                .frame(maxWidth: correctItemWidth * 0.8)
        }
        .frame(width: UIScreen.main.bounds.width / CGFloat(columns), height: correctHeight)
        .contentShape(Rectangle())
        .onTapGesture {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
        .transition(.opacity.animation(.spring().delay(Double(index) * 0.15)))
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
            PuraceVerticalGridView(columns: columns, spacing: 1) {
                ForEach(viewModel.collection.elements.indices, id: \.self) { index in
                    if type == "hero" {
                        heroElement(viewModel.collection.elements[index], index: index)
                    } else {
                        placeElement(viewModel.collection.elements[index], index: index)
                    }
                }
            }
        }
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 50, height: 50)
    }
    
    var body: some View {
        ZStack {
            VStack {
                navBar
                collection
                Spacer(minLength: 0)
            }
            if viewModel.isLoading {
                loader
                    .transition(.opacity)
            }
        }
        .navigationBarHidden(true)
            .snackBar(title: "Parece que ha habido un error", isVisible: $viewModel.errorHasOccured, type: .error, buttonTitle: "REINTENTAR")
            .onFirstAppear {
                withAnimation(.spring()) {
                    viewModel.getCollection(ofType: type, categoryId: categoryId)
                }
            }
            .onChange(of: viewModel.errorHasOccured) { value in
                if !value {
                    withAnimation(.spring()) {
                        viewModel.getCollection(ofType: type, categoryId: categoryId)
                    }
                }
            }
    }
}
