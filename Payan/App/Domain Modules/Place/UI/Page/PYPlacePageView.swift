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
                .skeleton(with: viewModel.isLoading)
                .shape(type: .rectangle)
                .animation(type: .none)
                .appearance(type: .solid())
            Color.black.opacity(imageOpacity)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
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
                    .skeleton(with: viewModel.isLoading)
                    .multiline(lines: 1)
                    .animation(type: .none)
                    .appearance(type: .solid())
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
                    .skeleton(with: viewModel.isLoading)
                    .multiline(lines: 1)
                    .animation(type: .none)
                    .appearance(type: .solid())
                    .padding(.top, viewModel.isLoading ? 5 : 0)
                if viewModel.isLoading {
                    Spacer(minLength: UIScreen.main.bounds.width * 0.35)
                }
            }
        }
    }
    
    var description: some View {
        DescriptionView(text: viewModel.place.description ?? "")
            .skeleton(with: viewModel.isLoading)
            .multiline(lines: 5, scales: [4: 0.5])
            .animation(type: .none)
            .appearance(type: .solid())
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
    
    var tabs: some View {
        PuraceTabView(titles: ["Ubicación", "Imágenes"]) { index in
            Group {
                if index == 0 {
                    location
                } else {
                    PuraceTextView("Not implemented yet!")
                }
            }
        }
    }
    
    func tryToUpdateNavBar(basedOn scrollOffset: CGFloat) {
        if scrollOffset < -UIScreen.main.bounds.height * 0.3 {
            navBarBackground = .white
            navBarForegroundColor = PuraceStyle.Color.N1
        } else {
            navBarBackground = .clear
            navBarForegroundColor = .white
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
    
    struct DescriptionView: View {
        var text: String

        @State private var height: CGFloat = .zero

        var body: some View {
            InternalLabelView(text: text, dynamicHeight: $height)
                .frame(minHeight: height)
        }

        struct InternalLabelView: UIViewRepresentable {
            var text: String
            @Binding var dynamicHeight: CGFloat

            func makeUIView(context: Context) -> UILabel {
                let label = UILabel()
                label.numberOfLines = 0
                label.textAlignment = .justified
                label.lineBreakMode = .byWordWrapping
                label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                label.textColor = UIColor(PuraceStyle.Color.N1)
                label.font = UIFont(name: "Poppins-Regular", size: 12)
                return label
            }

            func updateUIView(_ uiView: UILabel, context: Context) {
                uiView.text = text
                DispatchQueue.main.async {
                    dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
                }
            }
        }
    }
}
