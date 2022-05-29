//
//  PYPlacePageView.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation
import SwiftUI
import Purace

struct PYPlacePageView: View, PYPlaceViewLogic {
    var placeId: String
    
    @StateObject var viewModel = PYPlaceViewModel()
    
    init(placeId: String) {
        self.placeId = placeId
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
    }
    
    var image: some View {
        let url = URL(string: viewModel.place.image)
        return ZStack {
            PuraceImageView(url: url)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35)
                .clipped()
            LinearGradient(colors: [.black.opacity(0.55), .clear], startPoint: .top, endPoint: .center)
        }.frame(height: UIScreen.main.bounds.height * 0.35)
    }
    
    var title: some View {
        PuraceTextView(viewModel.place.title, fontSize: 18, weight: .medium)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    image
                    title
                        .padding(.top)
                    Spacer()
                }
            }
            VStack {
                navBar
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onFirstAppear {
            viewModel.getPlace(id: placeId)
        }
    }
}
