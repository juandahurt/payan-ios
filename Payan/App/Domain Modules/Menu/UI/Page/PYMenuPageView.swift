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

    var body: some View {
        ScrollView {
            PuraceTextView("Más", fontSize: 22)
            Spacer()
        }
            .padding(.top, 25)
            .navigationBarHidden(true)
            .onFirstAppear {
                viewModel.getSections()
                PYRoutingManager.shared.open(url: URL(string: "payan://")!)
            }
    }
}
