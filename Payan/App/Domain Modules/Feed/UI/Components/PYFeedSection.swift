//
//  PYFeedSection.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 7/12/22.
//

import SwiftUI

struct PYFeedSection<Header: View, Content: View>: View {
    let header: Header
    let content: () -> Content
    
    var body: some View {
        VStack(spacing: 22) {
            header
            content()
        }
    }
}
