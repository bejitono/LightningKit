//
//  LNSListPaymentsRequest.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 21.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

public struct LNSListPaymentsRequest {
    
    public let includeIncomplete: Bool
    ///The index of a payment that will be used as either the start or end of a
    ///query to determine which payments should be returned in the response.
    public let indexOffset: Int
    //// The maximal number of payments returned in the response to this query.
    public let maxPayments: Int
    public let reversed: Bool

    public init(includeIncomplete: Bool = false,
                indexOffset: Int = 0,
                maxPayments: Int = 0,
                reversed: Bool = false) {
        self.includeIncomplete = includeIncomplete
        self.indexOffset = indexOffset
        self.maxPayments = maxPayments
        self.reversed = reversed
    }
}
