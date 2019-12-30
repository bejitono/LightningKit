//
//  LNSPayment.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 30.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct LNSPayment: Equatable {
    
    public let paymentHash: String
    public let memo: String?
    public let amount: Int
    public let date: Date
    public let fees: Int
    public let destination: String
    public let preimage: String
    
    public init(paymentHash: String,
                memo: String?,
                amount: Int,
                date: Date,
                fees: Int,
                destination: String,
                preimage: String) {
        self.paymentHash = paymentHash
        self.memo = memo
        self.amount = amount
        self.date = date
        self.fees = fees
        self.destination = destination
        self.preimage = preimage
    }
}
