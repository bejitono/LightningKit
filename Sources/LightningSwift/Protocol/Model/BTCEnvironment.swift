//
//  BTCEnvironment.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public enum BTCEnvironment {
    case mainnet
    case regtest
    case simnet
    case testnet
}

public extension BTCEnvironment {
    
    var argumentString: String {
        switch self {
        case .mainnet: return "--bitcoin.mainnet"
        case .regtest: return "--bitcoin.regtest"
        case .simnet: return "--bitcoin.simnet"
        case .testnet: return "--bitcoin.testnet"
        }
    }
}
