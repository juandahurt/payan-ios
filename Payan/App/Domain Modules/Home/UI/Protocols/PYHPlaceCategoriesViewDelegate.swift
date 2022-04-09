//
//  PYHPlaceCategoriesViewDelegate.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation


protocol PYHPlaceCategoriesViewDelegate: AnyObject {
    func placesCategoriesView(_ view: PYHPlaceCategoriesView, didSelectCategoryAt index: Int)
}
