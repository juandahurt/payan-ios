//
//  PYHSectionItemFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYHSectionItemFactory {
    static func createSectionItemCell(for layout: PYHItemLayout, item: PYHSectionItem, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHBasicCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHBasicCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setImage("https://upload.wikimedia.org/wikipedia/commons/7/79/Josehilariolopez1.png")
                cell.setTitle("Nombre del prócer")
            }
            return cell
        case .collection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHCollectionCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setTitle("Museos")
                cell.setSubtitle("12 elementos")
                cell.setImage("https://payan-dev-images.s3.us-east-2.amazonaws.com/san-jose.jpg")
            }
            return cell
        case .innerCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHInnerCardCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHInnerCardCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setTitle("Universidad del Cauca")
                cell.setSubtitle("Pública")
                cell.setImage("https://upload.wikimedia.org/wikipedia/commons/2/23/Unicauca_-_El_Carmen_1.jpg")
                cell.setSecondaryImage("http://web.unicauca.edu.co/seminarioredmovil/images/unicauca.png")
            }
            return cell
        }
    }
}
