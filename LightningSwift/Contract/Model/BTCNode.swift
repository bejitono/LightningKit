//
//  BTCNode.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public enum BTCNode {
    case autopilot
    case bitcoin
    case neutrino
}

public extension BTCNode {
    
    var argumentString: String {
        let key = "--bitcoin.node="
        switch self {
        case .autopilot: return key + "autopilot"
        case .bitcoin: return key + "bitcoin"
        case .neutrino: return key + "neutrino"
        }
    }
}
