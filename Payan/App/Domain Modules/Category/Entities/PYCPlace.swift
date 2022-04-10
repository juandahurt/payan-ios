//
//  PYCPlace.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


struct PYCPlace {
    var id: String
    var name: String
    var image: String
}

#if DEBUG
extension PYCPlace {
    static let dummy: [PYCPlace] = [
        PYCPlace(id: "", name: "El morro de Tulcán", image: "https://payan-dev-images.s3.us-east-2.amazonaws.com/70af431a36f7c0e548b1e8b147927155.jpg"),
    ]
}
#endif
