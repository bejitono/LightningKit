//
//  LNSOpenChannelStatus.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSChannelPoint {

    public let fundingTransactionId: String
    public let outputIndex: Int
    
    public init(fundingTransactionId: String,
                outputIndex: Int) {
        self.fundingTransactionId = fundingTransactionId
        self.outputIndex = outputIndex
    }
}
