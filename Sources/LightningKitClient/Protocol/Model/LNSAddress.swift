//
//  LNSAddress.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 23.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSAddress {
    
    public let pubkey: String
    public let host: String
    
    public init(pubkey: String,
                host: String) {
        self.pubkey = pubkey
        self.host = host
    }
}
