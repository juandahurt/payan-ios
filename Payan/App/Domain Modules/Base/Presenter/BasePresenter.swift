//
//  BasePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation

protocol BasePresenter {
    associatedtype Router: BaseRouter
    var router: Router { get set }
}
