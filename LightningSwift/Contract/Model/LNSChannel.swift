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
    
//    public init(id: Int,
//                active: Bool,
//                localBalance: Int,
//                remoteBalance: Int,
//                capacity: Int,
//                remotePubKey: String,
//                channelPoint: String,
//                totalSent: Int,
//                totalReceived: Int,
//                isPrivate: Bool,
//                csvDelay: Int
//                //closeAddress: String
//    ) {
//        self.id = id
//        self.active = active
//        self.localBalance = localBalance
//        self.remoteBalance = remoteBalance
//        self.capacity = capacity
//        self.remotePubKey = remotePubKey
//        self.channelPoint = channelPoint
//        self.totalSent = totalSent
//        self.totalReceived = totalReceived
//        self.isPrivate = isPrivate
//        self.csvDelay = csvDelay
//        //self.closeAddress = closeAddress
//    }
}

public struct LNSPendingChannels {
    
    public let pendingOpenChannels: [LNSPendingChannel]
    public let pendingClosingChannels: [LNSPendingCloseChannel]
    public let pendingForceClosingChannels: [LNSPendingCloseChannel]
    public let waitingCloseChannels: [LNSPendingChannel]
    
//    public init(pendingOpenChannels: [LNSPendingChannel],
//                pendingClosingChannels: [LNSPendingCloseChannel],
//                pendingForceClosingChannels: [LNSPendingCloseChannel],
//                waitingCloseChannels: [LNSPendingChannel]) {
//        self.pendingOpenChannels = pendingOpenChannels
//        self.pendingClosingChannels = pendingClosingChannels
//        self.pendingForceClosingChannels = pendingForceClosingChannels
//        self.waitingCloseChannels = waitingCloseChannels
//    }
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
