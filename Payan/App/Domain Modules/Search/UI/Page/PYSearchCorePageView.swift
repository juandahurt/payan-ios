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
    
    init(viewModel: PYSearchCoreViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var searchBar: some View {
        HStack(spacing: 15) {
            PuraceSearchBox("Buscar", text: $viewModel.searchText)
                .focusedLegacy($focusedField, equals: .searchBar)
            
            PuraceTextView("Cancelar", fontSize: 10)
                .onTapGesture {
                    PYRoutingManager.shared.pop(animated: false)
                }
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
            focusedField = nil
            guard let url = URL(string: item.deepLink) else { return }
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
                        ForEach(result.items.indices, id: \.self) { itemIndex in
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
        VStack {
            PuraceCircularLoaderView(lineWidth: 4)
                .frame(width: 80, height: 80)
                .padding(.top, 50)
        }
    }
    
    var noResults: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("not-found")
            PuraceTextView("Uy", fontSize: 22, weight: .medium)
            PuraceTextView("Parece que no pudimos encontrar resultados para tu búsqueda. Prueba con otra palabra.", fontSize: 14)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding([.top, .horizontal], 50)
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
        }
        .background(
            PuraceStyle.Color.F1
        )
        .ignoresSafeArea(.keyboard)
        .onAppear {
            AnalyticsManager.shared.trackView(path: "/search", params: nil)
        }
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
