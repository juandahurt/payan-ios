//
//  PYSearchCorePageView.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Focuser
import Foundation
import SwiftUI
import Purace

struct PYSearchCorePageView: View {
    @StateObject var viewModel: PYSearchCoreViewModel
    @FocusStateLegacy var focusedField: SearchFields? = .searchBar
    
    init(viewModel: PYSearchCoreViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var searchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .onTapGesture {
                    PYRoutingManager.shared.pop(animated: false)
                }
            PuraceTextField("Buscar", text: $viewModel.searchText)
                .focusedLegacy($focusedField, equals: .last)
        }
        .padding(16)
        .background(
            Color.white
        )
    }

    func resultTitle(of result: PYSearchResult) -> some View {
        HStack {
            PuraceTextView(result.title, weight: .medium)
                .multilineTextAlignment(.leading)
                .padding(.top, 14)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
            Spacer(minLength: 0)
        }.background(Color.white)
    }
    
    func resultItemRow(of item: PYSearchResultItem) -> some View {
        HStack(spacing: 10) {
            Image("search-100")
            PuraceTextView(item.title)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .background(Color.white)
    }
    
    var results: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.results.indices, id: \.self) { index in
                    let result = viewModel.result(at: index)
                    resultTitle(of: result)
                    VStack(spacing: 0) {
                        ForEach(result.items.indices) { itemIndex in
                            let item = viewModel.item(of: result, at: itemIndex)
                            resultItemRow(of: item)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            if viewModel.isLoading {
                PuraceCircularLoaderView()
                    .frame(width: 80, height: 80)
                    .padding(.top, 50)
            } else {
                results
            }
            Spacer()
                .navigationBarHidden(true)
        }.background(Color.black.opacity(0.05))
    }
}

enum SearchFields {
    case searchBar
}

extension SearchFields: FocusStateCompliant {

    static var last: SearchFields {
        .searchBar
    }

    var next: SearchFields? {
        nil
    }
}
