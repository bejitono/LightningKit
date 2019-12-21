//
//  ChannelBalance.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSChannelBalance {
    
    public let balance: Int
    public let pendingBalance: Int

    public init(balance: Int,
                pendingBalance: Int) {
        self.balance = balance
        self.pendingBalance = pendingBalance
    }
}
