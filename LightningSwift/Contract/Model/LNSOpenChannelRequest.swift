//
//  LNSOpenChannelRequest.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSOpenChannelRequest {
    
    public let pubKey: String
    public let localFundingAmount: Int
    public let remoteFundingAmount: Int
    public let targetConfirmations: Int
    public let minimumConfirmations: Int
    public let isPrivate: Bool
    public let updateCount: Int
    public let csvDelay: Int?
    public let closeAddress: String?
}
