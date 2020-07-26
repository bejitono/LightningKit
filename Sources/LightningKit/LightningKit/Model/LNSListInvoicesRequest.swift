//
//  LNSListInvoicesRequest.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 21.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

public struct LNSListInvoicesRequest {
    
    public let pendingOnly: Bool
    public let indexOffset: Int
    public let numMaxInvoices: Int
    public let reversed: Bool

    public init(pendingOnly: Bool = false,
                indexOffset: Int = 0,
                numMaxInvoices: Int = 100,
                reversed: Bool = false) {
        self.pendingOnly = pendingOnly
        self.indexOffset = indexOffset
        self.numMaxInvoices = numMaxInvoices
        self.reversed = reversed
    }
}
