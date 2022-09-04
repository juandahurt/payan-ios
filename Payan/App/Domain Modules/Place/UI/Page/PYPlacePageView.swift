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
    
    var navBar: some View {
        HStack(alignment: .center) {
            VStack(spacing: 0) {
                Spacer()
                Image(systemName: "chevron.left")
                    .foregroundColor(PuraceStyle.Color.N1)
                    .scaleEffect(1.2)
                    .padding()
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        PYRoutingManager.shared.pop()
                    }
            }
            Spacer()
        }
            .frame(height: 50)
    }
    
    var image: some View {
        let url = URL(string: viewModel.place.image)
        return PuraceImageView(url: url)
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.height * 0.35)
            .clipped()
            .animation(.none)
            .skeleton(with: viewModel.isLoading)
            .shape(type: .rectangle)
            .frame(height: UIScreen.main.bounds.height * 0.35)
    }
    
    var title: some View {
        VStack(spacing: 10) {
            HStack {
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.3)
                }
                PuraceTextView(viewModel.place.title, fontSize: 22, textColor: PuraceStyle.Color.N2, weight: .medium)
                    .multilineTextAlignment(.center)
                    .skeleton(with: viewModel.isLoading, transition: .opacity)
                    .multiline(lines: 1)
                    .padding(.vertical, viewModel.isLoading ? 5 : 0)
                    .padding(.horizontal)
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.3)
                }
            }
            
            HStack {
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.35)
                }
                PuraceTextView(viewModel.place.subtitle, fontSize: 14, textColor: PuraceStyle.Color.N4)
                    .skeleton(with: viewModel.isLoading, transition: .opacity)
                    .multiline(lines: 1)
                    .padding(.top, viewModel.isLoading ? 5 : 0)
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.35)
                }
            }
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
            .padding(.horizontal, 30)
    }
    
    var images: some View {
        VStack(alignment: .leading, spacing: 27) {
            PuraceTextView("Descubre este lugar", fontSize: 18)
                .padding(.horizontal, 30)
            
            PuraceHorizontalGridView {
                ForEach(viewModel.place.images.reversed().indices) { index in
                    Color.clear
                        .background(
                            PuraceImageView(url: URL(string: viewModel.place.images.reversed()[index].url))
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        )
                        .clipped()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedImage = viewModel.place.images.count - index - 1
                            withAnimation {
                                selectedImageIsVisible = true
                            }
                        }
                }
            }.frame(height: UIScreen.main.bounds.height * 0.35)
        }
    }
    
    var body: some View {
        VStack {
            navBar
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 40) {
                    image
                    title
                    description
                    if viewModel.placeWasFetchedSuccesffully {
                        if !viewModel.place.images.isEmpty {
                            images
                        }
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .snackBar(title: "Parece que ha habido un error", isVisible: $viewModel.errorHasOccured, type: .error, buttonTitle: "REINTENTAR")
        .onChange(of: viewModel.errorHasOccured) { value in
            if !value {
                viewModel.getPlace(id: placeId)
            }
        }
        .imageViewer(
            urls: viewModel.place.images.map { URL(string: $0.url) },
            isVisible: $selectedImageIsVisible,
            selectedIndex: selectedImage
        )
        .navigationBarHidden(true)
        .onFirstAppear {
            viewModel.getPlace(id: placeId)
        }
        .onAppear {
            AnalyticsManager.shared.trackView(path: "/place", params: ["placeId": placeId])
        }
    }
}
