//
//  PYMapPageView.swift
//  Payan
//
//  Created by Juan Hurtado on 27/09/22.
//

import Foundation
import Purace
import SwiftUI

struct PYMapPageView: View {
    @State private var isSnackbarVisible = false
    @EnvironmentObject private var store: AppStore<PYMapState, PYMapAction, Any>
    
    func selectedLocationCard(location: PYPlaceLocation) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        
        return HStack(spacing: 15) {
            PuraceImageView(url: URL(string: location.imageUrl))
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(40)
            
            HStack {
                Spacer(minLength: 0)
                
                VStack {
                    PuraceTextView(location.title, fontSize: 20, weight: .medium)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                    
                    PuraceButtonView(PYMapConstants.Wordings.seeDetails, type: .quiet) {
                        guard let url = URL(string: location.link) else { return }
                        PYRoutingManager.shared.open(url: url)
                    }
                }
                
                Spacer(minLength: 0)
            }
        }
            .padding(.vertical, 20)
            .padding(.horizontal, 15)
            .frame(width: screenWidth - 60)
            .background(Color.white)
            .cornerRadius(15)
            .padding(.bottom, 20)
    }
    
    func selectedLocationCardWrapper() -> some View {
        VStack {
            Spacer()
            
            if let selectedLocation = store.state.selectedLocation {
                selectedLocationCard(location: selectedLocation)
            } else {
                EmptyView()
            }
        }
    }
    
    var loader: some View {
        PuraceCircularLoaderView(lineWidth: 2)
            .frame(width: 10, height: 10)
            .padding(5)
            .background(Color.white.opacity(0.5))
    }
    
    var loaderWrapper: some View {
        VStack {
            HStack {
                loader
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }
    
    var body: some View {
        ZStack {
            PYMapViewContainer()
            
            if store.state.isLoading {
                loaderWrapper
            }
            
            selectedLocationCardWrapper()
        }
        .snackBar(title: PYMapConstants.Wordings.errorOccured, isVisible: $isSnackbarVisible, type: .error, buttonTitle: PYMapConstants.Wordings.retry) {
            store.send(.getLocations)
        }
        .offset(x: 0, y: -0.5) // workaround to show the snackbar. :c
        .onChange(of: store.state.errorOccured) { newValue in
            isSnackbarVisible = newValue
        }
        .onFirstAppear {
            store.send(.getLocations)
            store.send(.requestAuth)
        }
        .onDisappear {
            store.send(.selectLocation(location: nil))
        }
        .onAppear {
            AnalyticsManager.shared.trackView(path: PYMapConstants.Analytics.pageName)
        }
    }
}
