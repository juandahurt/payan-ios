//
//  PYHeroPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 13/06/22.
//

import Foundation
import SwiftUI
import Purace

struct PYHeroPageView: View, PYHeroViewLogic {
    @StateObject var viewModel: PYHeroViewModel
    
    var heroId: String
    
    init(heroId: String, viewModel: PYHeroViewModel) {
        #warning("Apple says 'don't use this initializer' but how am i going to inject this????")
        _viewModel = StateObject(wrappedValue: viewModel)
        self.heroId = heroId
    }
    
    var navBar: some View {
        HStack(alignment: .center) {
            VStack(spacing: 0) {
                Spacer()
                Image(systemName: "chevron.left")
                    .foregroundColor(PuraceStyle.Color.N1)
                    .scaleEffect(1.2)
                    .onTapGesture {
                        PYRoutingManager.shared.pop()
                    }
                    .padding()
            }
            Spacer()
        }
            .frame(height: 50)
    }
    
    var body: some View {
        VStack {
            navBar
            Text("Hola")
            Spacer()
        }
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getHero(id: heroId)
            }
    }
}
