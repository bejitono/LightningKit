//
//  LNSWalletBalance.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSWalletBalance {
    
    public let totalBalance: Int
    public let confirmedBalance: Int
    public let unconfirmedBalance: Int

    public init(totalBalance: Int,
                confirmedBalance: Int,
                unconfirmedBalance: Int) {
        self.totalBalance = totalBalance
        self.confirmedBalance = confirmedBalance
        self.unconfirmedBalance = unconfirmedBalance
    }
}
