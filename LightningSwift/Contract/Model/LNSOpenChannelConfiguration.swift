//
//  LNSOpenChannelRequest.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSOpenChannelConfiguration {
    
    public let pubKey: String
    public let localFundingAmount: Int
    public let remoteFundingAmount: Int
    public let targetConfirmations: Int
    public let minimumConfirmations: Int
    public let isPrivate: Bool
    public let csvDelay: Int?
    
    public init(pubKey: String,
                localFundingAmount: Int,
                remoteFundingAmount: Int,
                targetConfirmations: Int,
                minimumConfirmations: Int,
                isPrivate: Bool,
                csvDelay: Int?) {
        self.pubKey = pubKey
        self.localFundingAmount = localFundingAmount
        self.remoteFundingAmount = remoteFundingAmount
        self.targetConfirmations = targetConfirmations
        self.minimumConfirmations = minimumConfirmations
        self.isPrivate = isPrivate
        self.csvDelay = csvDelay    }
}
