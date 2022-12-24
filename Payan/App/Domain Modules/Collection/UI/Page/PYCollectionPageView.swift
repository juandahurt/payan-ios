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
    
    @StateObject var store = AppStore(initialState: PYCollectionLoadingState(data: .skeleton), reducer: PYCollectionReducer(worker: PYCollectionNetworkWorker())).debug()
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
        columns = type == "hero" ? 2 : 3
        correctItemWidth = UIScreen.main.bounds.width / CGFloat(columns) - 30
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
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Color.clear
                    .background(
                        PuraceImageView(url: URL(string: element.image))
                            .scaledToFill()
                    )
                    .frame(height: correctHeight)
                    .clipped()
                    .contentShape(Rectangle())
                    .cornerRadius(15)
                
                HStack {
                    PuraceTextView(element.title, fontSize: 10, weight: .medium)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        
                    Spacer(minLength: 0)
                }
            }
        }
            .transition(.opacity.animation(.linear.delay(Double(index) * 0.1)))
            .buttonStyle(SquishableButton())
            
    }
    
    func heroElement(_ element: PYCollectionElement) -> some View {
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            VStack {
                Color.clear
                    .background(
                        PuraceImageView(url: URL(string: element.image))
                            .scaledToFill()
                    )
                    .frame(height: correctHeight)
                    .clipped()
                    .contentShape(Rectangle())
                    .cornerRadius(15)
                
                HStack {
                    PuraceTextView(element.title, fontSize: 12, weight: .medium)
                        .multilineTextAlignment(.leading)
                    
                    Spacer(minLength: 0)
                }
            }
        }.buttonStyle(SquishableButton())
    }
    
    func collection(data: PYCollection) -> some View {
        ScrollView {
            VStack(spacing: 25) {
                HStack {
                    PuraceTextView(data.title, fontSize: 22, weight: .medium)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
                PuraceVerticalGridView(columns: columns, spacing: 15) {
                    ForEach(data.elements.indices, id: \.self) { index in
                        let element = data.elements[index]
                        if type == "hero" {
                            heroElement(element)
                        } else {
                            placeElement(element, index: index)
                        }
                    }
                }
            }
                .padding(.horizontal, 20)
                .padding(.top, 30)
        }
        .transition(.opacity.animation(.linear))
    }
    
    var loader: some View {
        VStack {
            Spacer()
            
            PuraceCircularLoaderView()
                .frame(width: 50, height: 50)
            
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            navBar
            
            if store.state is PYCollectionLoadingState {
                loader
            }
            if let state = store.state as? PYCollectionSuccessState {
                collection(data: state.data)
            }
            
            Spacer(minLength: 0)
        }
        .navigationBarHidden(true)
        .snackBar(title: (store.state as? PYCollectionErrorState)?.description ?? "", isVisible: $errorHasOccurred, type: .error, buttonTitle: "REINTENTAR")
            .onFirstAppear {
                store.send(.getCollection(type, categoryId))
            }
            .onAppear {
                if type == "hero" {
                    AnalyticsManager.shared.trackView(path: "/heroes", params: nil)
                }
                if type == "place" {
                    AnalyticsManager.shared.trackView(path: "/places", params: nil)
                }
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
