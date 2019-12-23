//
//  LNSConnectPeerConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 23.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSConnectPeerConfiguration {
    
    public let address: LNSAddress
    public let permanent: Bool
    
    public init(address: LNSAddress,
                permanent: Bool) {
        self.address = address
        self.permanent = permanent
    }
}
