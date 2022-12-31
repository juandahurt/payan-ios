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
    
    let correctItemWidth: CGFloat
    let columns: Int
    
    @StateObject var store = AppStore(initialState: PYCollectionLoadingState(data: .skeleton), reducer: PYCollectionReducer(worker: PYCollectionNetworkWorker()))
    
    init(type: String, categoryId: String?) {
        self.type = type
        self.categoryId = categoryId
        columns = 1
        correctItemWidth = UIScreen.main.bounds.width / CGFloat(columns) - 30
    }
    
    func placeElement(_ element: PYCollectionElement, index: Int) -> some View {
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            HStack(spacing: 15) {
                PuraceImageView(url: URL(string: element.image))
                    .scaledToFill()
                    .frame(width: 80, height: 60)
                    .clipped()
                    .cornerRadius(10)
                VStack(spacing: 5) {
                    HStack {
                        PuraceTextView(element.title, fontSize: 16, weight: .medium)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        PuraceTextView(element.title, fontSize: 12, textColor: PuraceStyle.Color.N3)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(10)
                .background(Color.white)
                .cornerRadius(10)
        }.buttonStyle(SquishableButton())
            .frame(height: 80)
            .cornerRadius(15)
            
    }
    
    func heroElement(_ element: PYCollectionElement) -> some View {
        Button {
            guard let url = URL(string: element.deepLink) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            HStack(spacing: 15) {
                PuraceImageView(url: URL(string: element.image))
                    .scaledToFill()
                    .frame(width: 53, height: 80)
                    .clipped()
                VStack(spacing: 5) {
                    HStack {
                        PuraceTextView(element.title, fontSize: 16, weight: .medium)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        PuraceTextView(element.title, fontSize: 12, textColor: PuraceStyle.Color.N3)
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                }
            }.background(Color.white)
                .cornerRadius(10)
        }.buttonStyle(SquishableButton())
            .frame(height: 80)
            .cornerRadius(15)
    }
    
    func collection(data: PYCollection) -> some View {
        ScrollView {
            VStack(spacing: 40) {
                PuraceTextView(data.title, fontSize: 25, weight: .semibold)
                    .multilineTextAlignment(.center)
                
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
                .padding(.top, 40)
                .padding(.bottom, 20)
        }
        .transition(.opacity.animation(.linear))
    }
    
    var loader: some View {
        VStack {
            Spacer()
            
            PuraceCircularLoaderView()
                .frame(width: 50, height: 50)
            
            Spacer()
        }.frame(maxWidth: .infinity)
    }
    
    var body: some View {
        PuraceScaffold(navBar: .init(title: "", backOnTap: {
            PYRoutingManager.shared.pop()
        })) {
            PuraceScaffoldContent {
                Group {
                    if store.state is PYCollectionLoadingState {
                        loader
                    }
                    if let state = store.state as? PYCollectionSuccessState {
                        collection(data: state.data)
                    }
                }
            }.genericErrorView(isPresented: $store.state.errorHasOcurred) {
                store.send(.getCollection(type, categoryId))
            }
            .background(PuraceStyle.Color.F1)
        }
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
    }
}
