//
//  PYCollectionCellFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 6/05/22.
//

import Foundation
import UIKit

class PYCollectionCellFactory {
    static func createCell(for layout: PYCollectionLayout, element: PYCollectionElement, inside collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch layout {
        case .normal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYCollectionElementCollectionViewCell.reuseIdentifier, for: indexPath) as! PYCollectionElementCollectionViewCell
            cell.setImage(element.image)
            cell.setTitle(element.title)
            return cell
        case .oversized:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PYOversizedElementCollectionViewCell.reuseIdentifier, for: indexPath) as! PYOversizedElementCollectionViewCell
            cell.setImage(element.image)
            cell.setTitle(element.title)
            return cell
        }
    }
}
