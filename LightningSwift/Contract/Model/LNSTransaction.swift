//
//  LNSTransaction.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct LNSTransaction {
    
    public let hash: String
    public let amount: Int
    public let numberOfConfirmations: Int
    public let timestamp: Date
    public let fees: Int
    public let destinationAdresses: [BTCAddress]

    public init(hash: String,
                amount: Int,
                numberOfConfirmations: Int,
                timestamp: Date,
                fees: Int,
                destinationAdresses: [BTCAddress]) {
        self.hash = hash
        self.amount = amount
        self.numberOfConfirmations = numberOfConfirmations
        self.timestamp = timestamp
        self.fees = fees
        self.destinationAdresses = destinationAdresses
    }
}
