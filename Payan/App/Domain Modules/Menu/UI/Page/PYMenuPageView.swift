//
//  PYMenuPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYMenuPageView: View {
    @State var isModalVisible = false
    @StateObject var viewModel: PYMenuViewModel
    
    init(viewModel: PYMenuViewModel = PYMenuViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    func row(at index: Int) -> some View {
        let item = viewModel.items[index]
        return VStack(spacing: 0) {
            if let image = item.image {
                HStack {
                    Image(image)
                    PuraceTextView(item.title, weight: .medium)
                    Spacer()
                }
                    .padding(.leading)
                    .padding(.vertical, 10)
            } else {
                VStack(spacing: 5) {
                    HStack {
                        PuraceTextView(item.title, weight: .medium)
                        Spacer()
                    }
                    HStack {
                        PuraceTextView(item.content, textColor: PuraceStyle.Color.N4)
                        Spacer()
                    }
                }.padding(.leading)
                .padding(.vertical, 10)
            }
            
            Divider()
                .padding(.horizontal)
                .opacity(0.65)
        }
        .background(Color.white)
        .onTapGesture {
            viewModel.select(item: item)
            if !(viewModel.selectedItem?.isStatic ?? false) {
                isModalVisible.toggle()
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                PuraceTextView("Acerca de", fontSize: 22)
                VStack(spacing: 0) {
                    ForEach(viewModel.items.indices, id: \.self) { index in
                        row(at: index)
                    }
                }.padding(.top)
                Spacer()
            }
                .padding(.top, 25)
            PuraceModalView(title: viewModel.selectedItem?.title ?? "", content: viewModel.selectedItem?.content ?? "", isVisible: $isModalVisible)
        }
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getItems()
            }
    }
}
