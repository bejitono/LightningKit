//
//  LNSTransaction.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct LNSTransaction {
    
    let hash: String
    let amount: Int
    let numberOfConfirmations: Int
    let timestamp: Date
    let fees: Int
    let destinationAdresses: [BTCAddress]
}
