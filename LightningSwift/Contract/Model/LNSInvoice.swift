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
    
    let hash: Data
    let paymentRequest: LNSEncodedPaymentRequest
    let timestamp: Date
    let expiryDate: Date
    let state: LNSInvoiceState
}

public enum LNSInvoiceState {
    case open
    case settled
    case canceled
    case accepted
}
