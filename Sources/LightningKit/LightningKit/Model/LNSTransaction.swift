//
//  LNSTransaction.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public typealias LNSTransactionId = String

public struct LNSTransaction {
    
    public let hash: String
    public let amount: Int
    public let numberOfConfirmations: Int
    public let timestamp: Date
    public let fees: Int
    public let destinationAdresses: [BTCAddress]
}
