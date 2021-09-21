//
//  HTTPNetwork.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct RESTAPI {
    private static var _shared: RESTAPI?
    static var shared: RESTAPI {
        if _shared == nil {
            _shared = RESTAPI()
        }
        return _shared!
    }
    
    var baseUrl: String {
        switch AppConfig.environment {
        case .dev:
            return "https://payan-dev.herokuapp.com/"
        }
    }
}
