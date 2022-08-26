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
        VStack(spacing: 34) {
            ZStack {
                Color.black
                    .opacity(0.05)
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                
                Image(viewModel.item(at: index).image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.45)
                    .scaledToFit()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    PuraceTextView(viewModel.item(at: index).title, textColor: PuraceStyle.Color.N4)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
                HStack {
                    PuraceTextView(viewModel.item(at: index).content, fontSize: 20)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                }
            }.padding(.horizontal, 30)
        }
        .padding(.top, 35)
        .animation(.none)
    }
    
    var mainButton: some View {
        Button {
            if viewModel.currentIndex == viewModel.items.count-1 {
                continueOnTap()
            } else {
                withAnimation {
                    viewModel.next()
                }
            }
        } label: {
            ZStack {
                Circle()
                    .fill( PuraceStyle.Color.G1)
                    .frame(width: 60, height: 60)
                    .opacity(viewModel.currentIndex == viewModel.items.count - 1 ? 1 : 0.1)
                
                Image(systemName: "chevron.left")
                    .foregroundColor(viewModel.currentIndex == viewModel.items.count - 1 ? .white : PuraceStyle.Color.N1)
                    .scaleEffect(1.2)
                    .rotationEffect(.degrees(180))
            }
        }.buttonStyle(.plain)
    }
    
    var bottomBar: some View {
        HStack {
            indicators
            Spacer()
            mainButton
        }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
    }
    
    var indicators: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                Color.black
                    .opacity(0.05)
                    .cornerRadius(7)
                
                PuraceStyle.Color.B1
                    .cornerRadius(7)
                    .frame(width: reader.size.width * max(0.15, CGFloat(viewModel.currentIndex / (viewModel.items.count - 1)) ))
            }.frame(height: 7)
        }.frame(width: 70, height: 7)
    }
    
    var body: some View {
        ZStack {
            VStack {
                if !viewModel.items.isEmpty {
                    item(at: viewModel.currentIndex)
                    
                    Spacer(minLength: 0)
                    
                    bottomBar
                }
            }
        }
        .onAppear {
            viewModel.getData()
        }
    }
}
