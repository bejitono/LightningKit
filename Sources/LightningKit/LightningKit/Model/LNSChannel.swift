//
//  LNSChannel.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 29.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSChannel {
    
    public let id: Int
    public let active: Bool
    public let localBalance: Int
    public let remoteBalance: Int
    public let capacity: Int
    public let remotePubKey: String
    public let channelPoint: String // TODO: Use Channel Point model
    public let totalSent: Int
    public let totalReceived: Int
    public let isPrivate: Bool
    public let csvDelay: Int
    //public let closeAddress: String
}

public struct LNSPendingChannels {
    
    public let pendingOpenChannels: [LNSPendingChannel]
    public let pendingClosingChannels: [LNSPendingCloseChannel]
    public let pendingForceClosingChannels: [LNSPendingCloseChannel]
    public let waitingCloseChannels: [LNSPendingChannel]
}

public struct LNSPendingCloseChannel {
    
    public let pendingChannel: LNSPendingChannel
    public let closingTxId: String
}

public struct LNSPendingChannel {
    
    public let remoteNodePubKey: String
    public let channelPoint: String
    public let capacity: Int
    public let localBalance: Int
    public let remoteBalance: Int
}
