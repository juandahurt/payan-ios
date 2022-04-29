//
//  PYFeedSectionItemFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYFeedSectionItemFactory {
    static func createSectionItemCell(for layout: PYFeedItemLayoutType, item: PYFeedSectionItem, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedBasicCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedBasicCollectionViewCell
            if !(item is PYFeedLoadingSectionItem) {
                cell.setImage(item.image)
                cell.setTitle(item.title)
            }
            return cell
        case .collection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedCollectionCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedCollectionCollectionViewCell
            if !(item is PYFeedLoadingSectionItem) {
                cell.setTitle(item.title)
                cell.setSubtitle(item.subtitle ?? "")
                cell.setImage(item.image)
            }
            return cell
        case .innerCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedInnerCardCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedInnerCardCollectionViewCell
            if !(item is PYFeedLoadingSectionItem) {
                cell.setTitle(item.title)
                cell.setSubtitle(item.subtitle ?? "")
                cell.setImage(item.image)
                cell.setSecondaryImage("http://web.unicauca.edu.co/seminarioredmovil/images/unicauca.png")
            }
            return cell
        }
    }
}
