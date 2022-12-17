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
        }.background(Color.white)
        .padding(.horizontal, 20)
        .onTapGesture {
            guard let url = URL(string: item.deeplink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
    }
    
    var sections: some View {
        ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
            VStack(spacing: 15) {
                ForEach(viewModel.section(at: sectionIndex).items.indices, id: \.self) { itemIndex in
                    let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                    sectionItem(at: indexPath)
                    if itemIndex != viewModel.section(at: sectionIndex).items.count - 1 {
                        PuraceStyle.Color.N8
                            .frame(height: 1)
                    }
                }
            }
            .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.top, 16)
        }
    }
    
    var title: some View {
        HStack {
            PuraceTextView(PYMenuConstants.Wordings.title, fontSize: 22, weight: .medium)
            Spacer()
        }
        .padding([.leading, .bottom], 20)
    }
    
    var body: some View {
        PuraceScaffold(navBar: .init(title: PYMenuConstants.Wordings.title, showBackButton: false, backOnTap: {})) {
            VStack {
                sections
                Spacer()
            }.background(PuraceStyle.Color.F1)
        }
            .onFirstAppear {
                viewModel.getSections()
            }
            .onAppear {
                AnalyticsManager.shared.trackView(path: PYMenuConstants.Analytics.pageName)
            }
    }
}
