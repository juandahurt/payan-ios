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
    let topSafeAreaPadding: CGFloat
    
    @StateObject var viewModel = PYPlaceViewModel()
    
    @State var descriptionHeight: CGFloat = .zero
    @State var scrollOffset: CGFloat = .zero
    @State var imageOpacity: Double = 0.2
    @State private var mapLocation = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    @State var navBarBackground: Color = .clear
    @State var navBarForegroundColor: Color = .white
    
    init(placeId: String) {
        self.placeId = placeId
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        topSafeAreaPadding = window?.safeAreaInsets.top ?? .zero
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            VStack(spacing: 0) {
                Spacer()
                Image(systemName: "chevron.left")
                    .foregroundColor(navBarForegroundColor)
                    .scaleEffect(1.2)
                    .onTapGesture {
                        PYRoutingManager.shared.pop()
                    }
                    .padding()
            }
            Spacer()
        }
            .frame(height: 50 + topSafeAreaPadding)
            .background(navBarBackground)
    }
    
    var image: some View {
        let url = URL(string: viewModel.place.image)
        return ZStack {
            PuraceImageView(url: url)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                .clipped()
                .animation(.none)
                .skeleton(with: viewModel.isLoading)
                .shape(type: .rectangle)
            Color.black.opacity(imageOpacity)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                .opacity(viewModel.isLoading ? 0 : 1)
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
    
    func updateImageOpacity() {
        imageOpacity = max(min(0.7, -scrollOffset * 0.0035), 0.15)
    }
    
    var title: some View {
        VStack(spacing: 10) {
            HStack {
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.3)
                }
                PuraceTextView(viewModel.place.title, fontSize: 18, weight: .medium)
                    .multilineTextAlignment(.center)
                    .skeleton(with: viewModel.isLoading, transition: .opacity)
                    .multiline(lines: 1)
                    .padding(.vertical, viewModel.isLoading ? 5 : 0)
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.3)
                }
            }
            
            HStack {
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.35)
                }
                PuraceTextView(viewModel.place.subtitle, fontSize: 12, textColor: PuraceStyle.Color.N4)
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
    }
    
    var location: some View {
        Map(coordinateRegion: $mapLocation, annotationItems: [viewModel.place.location]) { location in
            MapMarker(coordinate: location.coordinates, tint: PuraceStyle.Color.G1)
        }.onReceive(viewModel.$isLoading) { loading in
            guard !loading else { return }
            mapLocation.center = viewModel.place.location.coordinates
        }
    }
    
    var images: some View {
        PuraceHorizontalGridView {
            ForEach(viewModel.place.images.indices) { index in
                Color.clear
                    .background(
                        PuraceImageView(url: URL(string: viewModel.place.images[index].url))
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    )
                    .clipped()
            }
        }
    }
    
    var tabs: some View {
        PuraceTabView(titles: viewModel.tabTitles) { index in
            Group {
                if index == 0 {
                    location
                } else {
                    images
                }
            }
        }
    }
    
    func tryToUpdateNavBar(basedOn scrollOffset: CGFloat) {
        withAnimation(.linear(duration: 0.15)) {
            if scrollOffset < -UIScreen.main.bounds.height * 0.3 {
                navBarBackground = .white
                navBarForegroundColor = PuraceStyle.Color.N1
            } else {
                navBarBackground = .clear
                navBarForegroundColor = .white
            }
        }
    }
    
    var body: some View {
        ZStack {
            OffsettableScrollView { value in
                scrollOffset = value.y
                updateImageOpacity()
                tryToUpdateNavBar(basedOn: value.y)
            } content: {
                VStack {
                    Group {
                        image
                        title
                            .padding(.top)
                        description
                            .padding()
                    }.offset(x: 0, y: -15)
                    if !viewModel.isLoading {
                        tabs
                            .frame(height: UIScreen.main.bounds.height * 0.5)
                    }
                    Spacer(minLength: 0)
                }
            }
            VStack {
                navBar
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .onFirstAppear {
            viewModel.getPlace(id: placeId)
        }
    }
}
