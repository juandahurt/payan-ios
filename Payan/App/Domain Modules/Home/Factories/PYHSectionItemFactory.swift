//
//  PYHSectionItemFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYHSectionItemFactory {
    static func createSectionItemCell(for layout: PYHItemLayoutType, item: PYHSectionItem, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHBasicCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHBasicCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setImage(item.image)
                cell.setTitle(item.title)
            }
            return cell
        case .collection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHCollectionCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setTitle(item.title)
                cell.setSubtitle("12 elementos")
                cell.setImage(item.image)
            }
            return cell
        case .innerCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHInnerCardCollectionViewCell.reuseIdentifier, for: indexPath) as! PYHInnerCardCollectionViewCell
            if !(item is PYHLoadingSectionItem) {
                cell.setTitle(item.title)
                cell.setSubtitle("Pública")
                cell.setImage(item.image)
                cell.setSecondaryImage("http://web.unicauca.edu.co/seminarioredmovil/images/unicauca.png")
            }
            return cell
        }
    }
}
