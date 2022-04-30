//
//  PYFeedSectionElementFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYFeedSectionElementFactory {
    static func createSectionElemetCell(for layout: PYFeedElementLayoutType, element: PYFeedSectionElement, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedBasicCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedBasicCollectionViewCell
            if !(element is PYFeedLoadingSectionElement) {
                cell.setImage(element.image)
                cell.setTitle(element.title)
            }
            return cell
        case .collection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedCollectionCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedCollectionCollectionViewCell
            if !(element is PYFeedLoadingSectionElement) {
                cell.setTitle(element.title)
                cell.setSubtitle(element.subtitle ?? "")
                cell.setImage(element.image)
            }
            return cell
        case .innerCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYFeedInnerCardCollectionViewCell.reuseIdentifier, for: indexPath) as! PYFeedInnerCardCollectionViewCell
            if !(element is PYFeedLoadingSectionElement) {
                cell.setTitle(element.title)
                cell.setSubtitle(element.subtitle ?? "")
                cell.setImage(element.image)
                cell.setSecondaryImage("http://web.unicauca.edu.co/seminarioredmovil/images/unicauca.png")
            }
            return cell
        }
    }
}
