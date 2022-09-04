//
//  PYSearchCorePageView.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Focuser
import Firebase
import Foundation
import SwiftUI
import Purace

struct PYSearchCorePageView: View {
    @StateObject var viewModel: PYSearchCoreViewModel
    @FocusStateLegacy var focusedField: SearchFields? = .searchBar
    @Binding var isVisible: Bool
    
    init(isVisible: Binding<Bool>, viewModel: PYSearchCoreViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
        _isVisible = isVisible
    }
    
    var searchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "chevron.left")
                .foregroundColor(PuraceStyle.Color.N1)
                .scaleEffect(1.2)
                .onTapGesture {
                    isVisible = false
                }
            PuraceTextField("Buscar", text: $viewModel.searchText)
                .focusedLegacy($focusedField, equals: .searchBar)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
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
                .lineLimit(1)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(viewModel.selectedItem == item ? Color.black.opacity(0.05) : Color.white)
        .onTapGesture {
            guard let url = URL(string: item.deepLink) else { return }
            isVisible = false
            PYRoutingManager.shared.open(url: url)
            AnalyticsManager.shared.logEvent(name: AnalyticsEventViewSearchResults, params: [AnalyticsParameterSearchTerm: item.title])
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    viewModel.select(item: item)
                })
                .onEnded({ _ in
                    viewModel.select(item: nil)
                })
        )
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
                .background(Color.white)
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
    }
    
    var loader: some View {
        ZStack {
            Color.white
            PuraceCircularLoaderView(lineWidth: 2)
                .frame(width: 10, height: 10)
                .padding(.vertical)
        }.frame(height: 40)
    }
    
    var noResults: some View {
        ZStack {
            Color.white
            PuraceTextView("No se encontraron resultados.")
        }.frame(height: 40)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            if viewModel.isLoading {
                loader
            } else {
                if viewModel.showNoResultsWereFound {
                    noResults
                } else {
                    results
                }
            }
            Spacer()
                .navigationBarHidden(true)
        }.background(
            Color.black.opacity(0.3)
                .onTapGesture {
                    isVisible = false
                }
        )
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
