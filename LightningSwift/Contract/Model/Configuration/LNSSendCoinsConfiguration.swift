//
//  LNSSendCoinsConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 31.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSSendCoinsConfiguration {
    
    public let address: String
    public let amount: Int
    public let targetConfirmations: Int
    public let sendAll: Bool
    
    public init(address: String,
                amount: Int,
                targetConfirmations: Int,
                sendAll: Bool) {
        self.address = address
        self.amount = amount
        self.targetConfirmations = targetConfirmations
        self.sendAll = sendAll
    }
}
