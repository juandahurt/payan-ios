//
//  PYLightStatusBarViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 24/12/22.
//

import SwiftUI

class PYLightStatusBarViewController<Content>: UIHostingController<Content> where Content: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
