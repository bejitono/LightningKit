//
//  LNSCloseChannelConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 30.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSCloseChannelConfiguration {
    
    public let channelPoint: LNSChannelPoint
    public let isForced: Bool
    public let targetConfirmations: Int
    // public let satPerByte: Int
    
    public init(channelPoint: LNSChannelPoint,
                isForced: Bool,
                targetConfirmations: Int) {
        self.channelPoint = channelPoint
        self.isForced = isForced
        self.targetConfirmations = targetConfirmations
    }
}
