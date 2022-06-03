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
    let bottomSafeAreaPadding: CGFloat
    @StateObject var viewModel = PYPlaceViewModel()
    @State var descriptionHeight: CGFloat = .zero
    @State var scrollOffset: CGFloat = .zero
    @State var imageOpacity: Double = 0.2
    @State private var placeLocation = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 2.443881,
            longitude: -76.605059
        ),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    
    init(placeId: String) {
        self.placeId = placeId
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        topSafeAreaPadding = window?.safeAreaInsets.top ?? .zero
        bottomSafeAreaPadding = window?.safeAreaInsets.bottom ?? .zero
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .scaleEffect(1.2)
                .onTapGesture {
                    PYRoutingManager.shared.pop()
                }
            Spacer()
        }.padding()
            .frame(height: 50)
            .padding(.top, topSafeAreaPadding)
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
        Map(coordinateRegion: $placeLocation, annotationItems: [viewModel.location]) { location in
            MapMarker(coordinate: location.location, tint: PuraceStyle.Color.G1)
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
            }.frame(height: UIScreen.main.bounds.height * 0.45)
        }
    }
    
    var body: some View {
        ZStack {
            OffsettableScrollView { value in
                scrollOffset = value.y
                updateImageOpacity()
            } content: {
                VStack {
                    image
                    title
                        .padding(.top)
                    description
                        .padding()
                    if !viewModel.isLoading {
                        tabs
                            .frame(minHeight: UIScreen.main.bounds.height * 0.45)
                            .padding(.bottom, bottomSafeAreaPadding)
                    }
                    Spacer()
                }.offset(x: 0, y: -15) // hack to fix unwanted blank space produced by scroll view
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
