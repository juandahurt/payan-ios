//
//  PYOnboardingPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYOnboardingPageView: View {
    @StateObject var viewModel: PYOnboardingViewModel
    
    var continueOnTap: () -> Void
    
    func item(at index: Int) -> some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    PuraceTextView(viewModel.item(at: index).title, fontSize: 24)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
                HStack {
                    PuraceTextView(viewModel.item(at: index).content, textColor: PuraceStyle.Color.N4)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
            }.padding(.horizontal, 40)
            
            Image(viewModel.item(at: index).image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
        }
    }
    
    var mainButton: some View {
        let type = viewModel.mainButtonType
        return PuraceButtonView(viewModel.buttonText, fontSize: 14, type: type) {
            if viewModel.currentIndex == viewModel.items.count-1 {
                continueOnTap()
            } else {
                viewModel.next()
            }
        }
    }
    
    var bottomBar: some View {
        HStack {
            indicators
            Spacer()
            mainButton
        }
            .padding(.horizontal, 35)
            .padding(.bottom, 20)
    }
    
    var indicators: some View {
        HStack {
            ForEach(viewModel.items.indices, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.currentIndex ? PuraceStyle.Color.G1 : PuraceStyle.Color.G8)
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { reader in
                TabView(selection: $viewModel.currentIndex) {
                    ForEach(viewModel.items.indices, id: \.self) { index in
                        item(at: index)
                            .tag(index)
                    }
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .onChange(of: viewModel.currentIndex) { index in
                        reader.scrollTo(index)
                    }
            }
            
            bottomBar
        }.onAppear {
            viewModel.getData()
        }
    }
}
