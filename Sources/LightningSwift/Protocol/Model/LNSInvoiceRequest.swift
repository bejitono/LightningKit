//
//  LNSInvoiceConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct LNSInvoiceRequest {
    
    public let amount: Int
    public let memo: String?
    public let expiryDate: Date?

    public init(amount: Int,
                memo: String?,
                expiryDate: Date?) {
        self.amount = amount
        self.memo = memo
        self.expiryDate = expiryDate
    }
}
