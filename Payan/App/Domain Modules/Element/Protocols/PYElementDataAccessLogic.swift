//
//  PYElementDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

protocol PYElementDataAccessLogic {
    func getElementData(id: String, _ completion: @escaping (Result<[PYElementSection], Error>) -> Void)
}
