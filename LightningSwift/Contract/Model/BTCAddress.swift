//
//  BTCAddress.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct BTCAddress {
    
    public let address: String
    // let type: BTCAddressType

    public init() {
        
    }
}

public enum BTCAddressType {
    case P2PKH
    case P2SH
    case Bech32
}
