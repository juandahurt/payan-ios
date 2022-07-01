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

    func sectionItem(at indexPath: IndexPath) -> some View {
        let item = viewModel.item(at: indexPath)
        return HStack(spacing: 12) {
            if let icon = item.icon {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            PuraceTextView(item.title, weight: .medium)
            Spacer()
        }
    }
    
    var sections: some View {
        ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
            ForEach(viewModel.section(at: sectionIndex).items.indices) { itemIndex in
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                sectionItem(at: indexPath)
            }
            if sectionIndex != viewModel.sections.count - 1 {
                Divider()
                    .opacity(0.65)
            }
        }.padding(.horizontal)
    }
    
    var body: some View {
        ScrollView {
            PuraceTextView("Más", fontSize: 22)
            sections
            Spacer()
        }
            .padding(.top, 25)
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getSections()
            }
    }
}
