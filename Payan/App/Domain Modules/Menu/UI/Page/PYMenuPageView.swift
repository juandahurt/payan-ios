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
        .onTapGesture {
            guard let url = URL(string: item.deeplink) else { return }
            PYRoutingManager.shared.open(url: url)
        }
        .padding(.horizontal, 20)
    }
    
    var sections: some View {
        ForEach(viewModel.sections.indices, id: \.self) { sectionIndex in
            ForEach(viewModel.section(at: sectionIndex).items.indices, id: \.self) { itemIndex in
                let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
                sectionItem(at: indexPath)
            }
            if sectionIndex != viewModel.sections.count - 1 {
                Divider()
                    .padding(.leading, 20)
            }
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
        ScrollView {
            title
            sections
            Spacer()
        }
            .padding(.top, 25)
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getSections()
            }
            .onAppear {
                AnalyticsManager.shared.trackView(path: PYMenuConstants.Analytics.pageName)
            }
    }
}
