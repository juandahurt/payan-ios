//
//  PYHPlaceCategoriesViewDataSource.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation
import UIKit


protocol PYHPlaceCategoriesViewDataSource: AnyObject {
    func placesCategoriesView(numberOfCategoriesIn view: PYHPlaceCategoriesView) -> Int
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryTitleAt index: Int) -> String
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, categoryImageAt index: Int) -> UIImage
}
