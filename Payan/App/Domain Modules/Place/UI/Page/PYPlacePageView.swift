//
//  PYPlacePageView.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation
import MapKit
import SwiftUI
import Purace

struct PYPlacePageView: View, PYPlaceViewLogic {
    var placeId: String
    
    @StateObject var viewModel = PYPlaceViewModel()
    
    @State var selectedImageIsVisible = false
    @State var selectedImage: Int = 0
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                PuraceTextView(viewModel.place.title, fontSize: 25, textColor: PuraceStyle.Color.N2, weight: .semibold)
                    .multilineTextAlignment(.leading)
                    .skeleton(with: viewModel.isLoading, transition: .opacity)
                    .multiline(lines: 1, scales: [0: 0.35])
                    .padding(.vertical, viewModel.isLoading ? 5 : 0)
                
                Spacer(minLength: 0)
            }.padding(.horizontal, 20)
            
            HStack {
                PuraceTextView(viewModel.place.subtitle, fontSize: 14, textColor: PuraceStyle.Color.N4)
                    .multilineTextAlignment(.leading)
                    .skeleton(with: viewModel.isLoading, transition: .opacity)
                    .multiline(lines: 1, scales: [0: 0.2])
                    .padding(.top, viewModel.isLoading ? 5 : 0)
                
                Spacer(minLength: 0)
            }.padding(.horizontal, 20)
        }
    }
    
    var description: some View {
        HStack(spacing: 0) {
            PuraceTextView(viewModel.place.description ?? "")
                .skeleton(with: viewModel.isLoading, transition: .opacity)
                .multiline(lines: 5, scales: [0: 0.9, 2: 0.95, 4: 0.5])
            Spacer(minLength: 0)
        }
            .padding(.top, viewModel.isLoading ? 15 : 0)
            .padding(.horizontal, 20)
    }
    
    var images: some View {
        GeometryReader { reader in
            let minY = reader.frame(in: .named("scroll")).minY
            
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $viewModel.currentImageIndex) {
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        Color.clear
                            .background(
                                PuraceImageView(url: URL(string: viewModel.images[index]))
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                )
                            .clipped()
                            .contentShape(Rectangle())
                            .overlay(
                                LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .center)
                            )
                            .tag(index)
                    }
                }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                
                if viewModel.images.count > 1 {
                    HStack {
                        ForEach(0..<viewModel.images.count, id: \.self) { index in
                            Circle()
                                .fill(Color.white.opacity(index == viewModel.currentImageIndex ? 1 : 0.2))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding()
                }
            }
            .offset(y: minY < 0 ? 0 : -minY)
                .frame(height: reader.size.height + (minY < 0 ? 0 : minY))
        }
            .frame(height: UIScreen.main.bounds.height * 0.35)
    }
    
    var body: some View {
        PuraceScaffold(navBar: .init(title: "", backOnTap: {
            PYRoutingManager.shared.pop()
        })) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 30) {
                    images
                    title
                    description
                    Spacer(minLength: 0)
                }
            }.coordinateSpace(name: "scroll")
        }
        .background(PuraceStyle.Color.F1)
        .onChange(of: viewModel.errorHasOccured) { value in
            if !value {
                viewModel.getPlace(id: placeId)
            }
        }
        .onFirstAppear {
            viewModel.getPlace(id: placeId)
        }
        .onAppear {
            AnalyticsManager.shared.trackView(path: "/place", params: ["placeId": placeId])
        }
    }
}
