//
//  PYFeedPlaceCategory.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import Purace
import SwiftUI

struct PYFeedPlaceCategory: View {
    let link: String
    let image: String
    let title: String
    let numberOfPlaces: Int
    
    var body: some View {
        Button {
            guard let url = URL(string: link) else { return }
            PYRoutingManager.shared.open(url: url)
        } label: {
            ZStack {
                PuraceImageView(url: URL(string: image))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 3)
                    .clipped()
                
                LinearGradient(colors: [.clear, .black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            PuraceTextView(title, fontSize: 16, textColor: .white, weight: .medium)
                            
                            PuraceTextView("\(numberOfPlaces) lugares", fontSize: 10, textColor: .white)
                        }.padding()
                        
                        Spacer()
                    }
                }
                
            }
            .cornerRadius(10)
            .contentShape(Rectangle())
            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 3)
        }.buttonStyle(SquishableButton())
    }
}
