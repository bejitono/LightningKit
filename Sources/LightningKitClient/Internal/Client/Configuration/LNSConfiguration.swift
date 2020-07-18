//
//  LightningSwiftConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSConfiguration {
    
    public let macaroon: LNSMacaroon?
    public let btcEnvironment: BTCEnvironment
    public let btcNode: BTCNode

    public init(macaroon: LNSMacaroon?,
                btcEnvironment: BTCEnvironment,
                btcNode: BTCNode) {
        self.macaroon = macaroon
        self.btcEnvironment = btcEnvironment
        self.btcNode = btcNode
    }
}

public extension LNSConfiguration {
    
    static var defaultConfig: LNSConfiguration {
        return .init(macaroon: nil, btcEnvironment: .testnet, btcNode: .neutrino)
    }
}
