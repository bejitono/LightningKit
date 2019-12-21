//
//  LNSCoreMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

typealias LNSCoreMapper = LNSCoreRequestMapper & LNSCoreResponseMapper

protocol LNSCoreRequestMapper {

    func requestGetInfo() -> Lnrpc_GetInfoRequest
}

protocol LNSCoreResponseMapper {

    func map(getInfoResponse resp: Lnrpc_GetInfoResponse) -> LNSInfo
}

struct LNSCoreMapperImplementation: LNSCoreRequestMapper {

    func requestGetInfo() -> Lnrpc_GetInfoRequest {
        return Lnrpc_GetInfoRequest()
    }
}

extension LNSCoreMapperImplementation: LNSCoreResponseMapper {

    func map(getInfoResponse resp: Lnrpc_GetInfoResponse) -> LNSInfo {
        return LNSInfo(
            pubKey: resp.identityPubkey,
            alias: resp.alias,
            numPendingChannels: Int(resp.numPendingChannels),
            numActiveChannels: Int(resp.numActiveChannels),
            numInactiveChannels: Int(resp.numInactiveChannels),
            numPeers: Int(resp.numPeers),
            blockHeight: Int(resp.blockHeight),
            blockHash: resp.blockHash,
            syncedToChain: resp.syncedToChain,
            syncedToGraph: resp.syncedToGraph,
            testnet: resp.testnet,
            uris: resp.uris,
            bestHeaderTimestamp: Int(resp.bestHeaderTimestamp),
            version: resp.version
        )
    }
}
