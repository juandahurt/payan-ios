//
//  UIImageView+loadFromUrl.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


extension UIImageView {
    func load(fromUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
