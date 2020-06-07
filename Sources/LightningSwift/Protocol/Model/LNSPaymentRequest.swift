//
//  LNSPaymentRequest.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

public struct LNSPaymentRequest {
    
    public let paymentHash: String
    public let destination: String
    public let amount: Int
    public let memo: String?
    public let date: Date
    public let expiryDate: Date
    public let raw: String
    public let network: BTCEnvironment

    public init(paymentHash: String,
                destination: String,
                amount: Int,
                memo: String?,
                date: Date,
                expiryDate: Date,
                raw: String,
                network: BTCEnvironment) {
        self.paymentHash = paymentHash
        self.destination = destination
        self.amount = amount
        self.memo = memo
        self.date = date
        self.expiryDate = expiryDate
        self.raw = raw
        self.network = network
    }
}
