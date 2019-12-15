//
//  LNSInvoiceConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

public struct LNSInvoiceRequest {
    
    let amount: Int
    let memo: String?
    let expiryDate: Date?
}
