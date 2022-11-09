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
    @State private var isSnackbarVisible = true
    @EnvironmentObject private var store: AppStore<PYMapState, PYMapAction, Any>
    
    var cityName: some View {
        PuraceTextView(PYMapConstants.Wordings.cityName, fontSize: 10, weight: .medium)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(
                Color.white
                    .opacity(0.8)
            )
            .cornerRadius(8)
    }
    
    var topBarWrapper: some View {
        VStack {
            HStack {
                cityName
                    .padding()
                Spacer()
            }
            Spacer()
        }
    }
    
    func selectedLocationCard(location: PYPlaceLocation) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        
        return VStack {
            PuraceTextView(location.title, fontSize: 20, weight: .medium)
                .lineLimit(1)
                .multilineTextAlignment(.center)
            
            HStack {
                PuraceButtonView(PYMapConstants.Wordings.close, type: .transparent) {
                    store.send(.selectLocation(location: nil))
                }
                
                Spacer()
                
                PuraceButtonView(PYMapConstants.Wordings.seeDetails, type: .quiet)
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
    
    var body: some View {
        ZStack {
            PYMapViewContainer()
            
            topBarWrapper
            
            selectedLocationCardWrapper()
        }
        .snackBar(title: PYMapConstants.Wordings.loading, isVisible: $isSnackbarVisible)
        .offset(x: 0, y: -0.5) // workaround to show the snackbar. :c
        .onChange(of: store.state.isLoading) { newValue in
            isSnackbarVisible = newValue
        }
        .onFirstAppear {
            store.send(.getLocations)
        }
        .onDisappear {
            store.send(.selectLocation(location: nil))
        }
        .onAppear {
            AnalyticsManager.shared.trackView(path: PYMapConstants.Analytics.pageName)
        }
    }
}
