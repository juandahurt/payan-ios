//
//  SelectedPlaceView.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import Kingfisher
import SwiftUI

struct SelectedPlaceView: View {
    private let place: Place
    private let size: CGSize
    
    var seeMoreOnTap: (() -> Void)?
    var onCloseTap: (() -> Void)?
    
    init(in size: CGSize, place: Place, seeMoreOnTap: (() -> Void)?,onCloseTap: (() -> Void)?) {
        self.size = size
        self.place = place
        self.seeMoreOnTap = seeMoreOnTap
        self.onCloseTap = onCloseTap
    }
    
    var title: some View {
        HStack(alignment: .center) {
            closeButton
                .opacity(0)
            Spacer()
            Text(place.name)
                .font(Font(AppStyle.Font.get(.semiBold, size: .title) as CTFont))
                .foregroundColor(.black)
            Spacer()
            closeButton
        }
        .padding([.trailing, .top])
    }
    
    var closeButton: some View {
        ZStack {
            Circle()
                .fill(Color(AppStyle.Color.primary.withAlphaComponent(0.35)))
            Image("close")
                .resizable()
                .frame(width: 15, height: 15)
        }.frame(width: 40, height: 40)
            .onTapGesture {
                onCloseTap?()
            }
    }
    
    var seeMoreButton: some View {
        ZStack {
            Color(AppStyle.Color.primary)
                .cornerRadius(AppStyle.UIConstants.buttonCornerRadius)
            Text("Ver más")
                .font(Font(AppStyle.Font.get(.semiBold, size: .title) as CTFont))
                .foregroundColor(.white)
        }.frame(width: size.width - 80, height: 45)
            .onTapGesture {
                seeMoreOnTap?()
            }
    }
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(22)
                .opacity(0.85)
            VStack {
                title
                seeMoreButton
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: size.width, maxHeight: 135)
    }
}
