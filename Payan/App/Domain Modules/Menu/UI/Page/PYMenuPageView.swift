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
            PuraceTextView(item.title, fontSize: 14, weight: .medium)
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
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
    }
    
    var title: some View {
        PuraceTextView(PYMenuConstants.Wordings.title, fontSize: 25, weight: .semibold)
            .multilineTextAlignment(.center)
            .padding(.top, 30)
    }
    
    var body: some View {
        PuraceScaffold {
            VStack(spacing: 30) {
                title
                
                VStack {
                    sections
                    Spacer()
                }
            }
        }
        .background(
            ZStack {
                PuraceStyle.Color.F1
                
                VStack {
                    LinearGradient(colors: [.white, PuraceStyle.Color.F1], startPoint: .top, endPoint: .bottom)
                        .frame(height: 100)
                    Spacer()
                }
            }
        )
            .onFirstAppear {
                viewModel.getSections()
            }
            .onAppear {
                AnalyticsManager.shared.trackView(path: PYMenuConstants.Analytics.pageName)
            }
    }
}
