//
//  LNSAddressType+Init.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 23.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

extension LNSAddressType {
    
    var lndAddressType: Lnrpc_AddressType {
        switch self {
        case .p2wkh: return .witnessPubkeyHash
        case .np2wkh: return .nestedPubkeyHash
        }
    }
}
