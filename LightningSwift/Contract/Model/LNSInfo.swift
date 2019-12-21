//
//  LNSInfo.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSInfo {
    
    public let pubKey: String
    public let alias: String
    public let numPendingChannels: Int
    public let numActiveChannels: Int
    public let numInactiveChannels: Int
    public let numPeers: Int
    public let blockHeight: Int
    public let blockHash: String
    public let syncedToChain: Bool
    public let syncedToGraph: Bool
    public let testnet: Bool
    public let uris: [String]
    public let bestHeaderTimestamp: Int
    public let version: String

    public init(pubKey: String,
                alias: String,
                numPendingChannels: Int,
                numActiveChannels: Int,
                numInactiveChannels: Int,
                numPeers: Int,
                blockHeight: Int,
                blockHash: String,
                syncedToChain: Bool,
                syncedToGraph: Bool,
                testnet: Bool,
                uris: [String],
                bestHeaderTimestamp: Int,
                version: String) {
        self.pubKey = pubKey
        self.alias = alias
        self.numPendingChannels = numPendingChannels
        self.numActiveChannels = numActiveChannels
        self.numInactiveChannels = numInactiveChannels
        self.numPeers = numPeers
        self.blockHeight = blockHeight
        self.blockHash = blockHash
        self.syncedToChain = syncedToChain
        self.syncedToGraph = syncedToGraph
        self.testnet = testnet
        self.uris = uris
        self.bestHeaderTimestamp = bestHeaderTimestamp
        self.version = version
    }
}
