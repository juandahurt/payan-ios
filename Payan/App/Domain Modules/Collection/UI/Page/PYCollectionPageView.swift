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
    
    @State var title = ""
    @State var errorHasOccurred = false
    
    let heroHeight = UIScreen.main.bounds.width * 0.8
    let correctHeight: CGFloat
    let correctItemWidth: CGFloat
    let columns: Int
    
    @StateObject var store = AppStore(initialState: PYCollectionLoadingState(), reducer: PYCollectionReducer(), environment: PYCollectionEnvironment()).debug()
    
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
    
    func placeElement(_ element: PYCollectionElement) -> some View {
        ZStack {
            PuraceImageView(url: URL(string: element.image))
                .aspectRatio(contentMode: .fill)
                .frame(width: correctItemWidth, height: correctHeight)
                .clipped()
            Color.black.opacity(0.18)
            VStack {
                Spacer()
                HStack {
                    PuraceTextView(element.title, textColor: .white, weight: .regular)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .padding()
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
    }
    
    func heroElement(_ element: PYCollectionElement) -> some View {
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
    }
    
    func collection(data: PYCollection) -> some View {
        OffsettableScrollView { value in
            if value.y < -70 {
                title = data.title
            } else {
                title = ""
            }
        } content: {
            PuraceTextView(data.title, fontSize: 22)
                .padding(.bottom, 20)
                .frame(height: 70)
            PuraceVerticalGridView(columns: columns, spacing: 1.5) {
                ForEach(data.elements) { element in
                    if type == "hero" {
                        heroElement(element)
                    } else {
                        placeElement(element)
                    }
                }
            }
        }
        .transition(.opacity.animation(.spring()))
    }
    
    var loader: some View {
        PuraceCircularLoaderView()
            .frame(width: 50, height: 50)
            .transition(.opacity.animation(.spring()))
    }
    
    var body: some View {
        ZStack {
            VStack {
                navBar
                if let store = store.state as? PYCollectionSuccessState {
                    collection(data: store.data)
                }
                Spacer(minLength: 0)
            }
            if store.state is PYCollectionLoadingState {
                loader
            }
        }
        .navigationBarHidden(true)
        .snackBar(title: (store.state as? PYCollectionErrorState)?.description ?? "", isVisible: $errorHasOccurred, type: .error, buttonTitle: "REINTENTAR")
            .onFirstAppear {
                store.send(.getCollection(type, categoryId))
            }
            .onChange(of: store.state) { newValue in
                errorHasOccurred = newValue is PYCollectionErrorState
            }
            .onChange(of: errorHasOccurred) { newValue in
                if !newValue {
                    store.send(.getCollection(type, categoryId))
                }
            }
    }
}
