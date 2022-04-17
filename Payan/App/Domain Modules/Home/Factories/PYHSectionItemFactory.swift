//
//  PYHSectionItemFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYHSectionItemFactory {
    static func createSectionItemCell(for layout: PYHItemLayout, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHBasicCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        case .collection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHCollectionCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        case .innerCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYHInnerCardCollectionViewCell.reuseIdentifier, for: indexPath)
            return cell
        }
    }
}
