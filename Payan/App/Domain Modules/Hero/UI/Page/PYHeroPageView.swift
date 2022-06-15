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
    
    var title: some View {
        VStack(spacing: 10) {
            PuraceTextView(viewModel.hero.name, fontSize: 18, weight: .medium)
            PuraceTextView("1867 - 1934", fontSize: 12, textColor: PuraceStyle.Color.N4, weight: .medium)
        }.padding()
    }
    
    var image: some View {
        ZStack {
            PuraceStyle.Color.N8
            PuraceImageView(url: URL(string: viewModel.hero.image))
                .scaledToFit()
                .frame(maxHeight: UIScreen.main.bounds.height * 0.4)
        }
    }
    
    var description: some View {
        HStack(spacing: 0) {
            PuraceTextView(viewModel.hero.description)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 0)
        }
            .padding()
    }
    
    var sections: some View {
        VStack(spacing: 0) {
            ForEach(0..<5) { _ in
                PuraceAccordionView(title: "Biografía") {
                    HStack(spacing: 0) {
                        PuraceTextView("ahfjdhaflfahlsfhjkl alshlfjaksh ksdj kjh iuy nvcoiq kaoi nlj asdj opu ou es ounncp oi if aljpqoeiu falkfpq moi for i in arrat jasodf apoqp vd")
                            .multilineTextAlignment(.leading)
                        Spacer(minLength: 0)
                    }.padding()
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            navBar
            ScrollView {
                title
                image
                description
                sections
            }
            Spacer()
        }
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getHero(id: heroId)
            }
    }
}
