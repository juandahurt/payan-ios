//
//  PYHSectionLayoutFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation
import UIKit

class PYHSectionLayoutFactory {
    static func createSectionLayout(for section: PYHSection) -> NSCollectionLayoutSection {
        switch section.layout {
        case .grid:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalHeight(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 7.5, bottom: 0, trailing: 7.5)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.4)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.contentInsets = .init(top: 15, leading: 12.5, bottom: 0, trailing: 12.5)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            header.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.contentInsets = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
            
            return section
        case .horizontal:
            var width: CGFloat = 100
            var height: CGFloat = 100
            if let dimensions = section.itemLayout.dimensions {
                width = CGFloat(dimensions.width)
                height = CGFloat(dimensions.height)
            }
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(width),
                heightDimension: .absolute(height)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = .init(top: 15, leading: 0, bottom: 0, trailing: 15)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
    }
}
