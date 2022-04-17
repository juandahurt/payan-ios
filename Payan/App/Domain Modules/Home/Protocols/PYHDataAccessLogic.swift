//
//  PYHDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation


protocol PYHDataAccessLogic {
    func getLastVersion(completion: ((PYHAppVersion) -> Void)?)
    func getData(completion: ([PYHSection]) -> Void)
}
