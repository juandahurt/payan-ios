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
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            ZStack {
                Color.clear
                    .background(
                        PuraceImageView(url: URL(string: element.image)) {
                            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .center)
                        }
                            .scaledToFill()
                    )
                    .frame(height: correctHeight)
                    .contentShape(Rectangle())
                
                VStack {
                    Spacer()
                    HStack {
                        PuraceTextView(element.title, fontSize: 10, textColor: .white, weight: .regular)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        Spacer(minLength: 0)
                    }
                }
            }
        }.buttonStyle(.plain)
    }
    
    func heroElement(_ element: PYCollectionElement) -> some View {
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            Color.clear
                .background(
                    ZStack {
                        PuraceImageView(url: URL(string: element.image))
                            .scaledToFill()
                        
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
                    }
                )
                .frame(height: correctHeight)
                .clipped()
                .contentShape(Rectangle())
        }.buttonStyle(.plain)
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
            PuraceVerticalGridView(columns: columns, spacing: 4) {
                ForEach(data.elements) { element in
                    if type == "hero" {
                        heroElement(element)
                    } else {
                        placeElement(element)
                            .clipped()
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
    
    var collectionSkeleton: some View {
        ScrollView {
            PuraceTextView("Loading", fontSize: 22, textColor: .white)
                .padding(20)
                .frame(height: 70)
            
            PuraceVerticalGridView(columns: columns, spacing: 4) {
                ForEach(0..<12) { index in
                    Color.black.opacity(0.04)
                        .frame(height: correctHeight)
                }
            }.padding(.top, 5)
        }
        .transition(.opacity.animation(.spring()))
        .introspectScrollView { scrollView in
            scrollView.isScrollEnabled = false
        }
    }
    
    var body: some View {
        VStack {
            navBar
            if let store = store.state as? PYCollectionSuccessState {
                collection(data: store.data)
            } else if store.state is PYCollectionLoadingState {
                collectionSkeleton
            }
            Spacer(minLength: 0)
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
