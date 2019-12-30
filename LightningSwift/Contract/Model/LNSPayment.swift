//
//  LNSPayment.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 30.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct Payment: Equatable {
    
    public let id: String
    public let memo: String?
    public let amount: Int
    public let date: Date
    public let fees: Int
    public let paymentHash: String
    public let destination: String
    public let preimage: String
    
    public init(id: String,
                memo: String?,
                amount: Int,
                date: Date,
                fees: Int,
                paymentHash: String,
                destination: String,
                preimage: String) {
        self.id = id
        self.memo = memo
        self.amount = amount
        self.date = date
        self.fees = fees
        self.paymentHash = paymentHash
        self.destination = destination
        self.preimage = preimage
    }
}
