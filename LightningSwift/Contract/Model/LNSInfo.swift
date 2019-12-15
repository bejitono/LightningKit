//
//  LNSInfo.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LNSInfo {
    
    let pubKey: String
    let alias: String
    let numPendingChannels: Int
    let numActiveChannels: Int
    let numInactiveChannels: Int
    let numPeers: Int
    let blockHeight: Int
    let blockHash: String
    let syncedToChain: Bool
    let syncedToGraph: Bool
    let testnet: Bool
    let uris: [String]
    let bestHeaderTimestamp: Int
    let version: String
}
