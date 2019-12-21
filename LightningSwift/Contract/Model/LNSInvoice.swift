//
//  LNSPaymentRequest.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

public typealias LNSEncodedPaymentRequest = String

public struct LNSInvoice {
    
    public let hash: Data
    public let paymentRequest: LNSEncodedPaymentRequest
    public let timestamp: Date
    public let expiryDate: Date
    public let state: LNSInvoiceState

    public init(hash: Data,
                paymentRequest: LNSEncodedPaymentRequest,
                timestamp: Date,
                expiryDate: Date,
                state: LNSInvoiceState) {
        self.hash = hash
        self.paymentRequest = paymentRequest
        self.timestamp = timestamp
        self.expiryDate = expiryDate
        self.state = state
    }
}

public enum LNSInvoiceState {
    case open
    case settled
    case canceled
    case accepted
}
