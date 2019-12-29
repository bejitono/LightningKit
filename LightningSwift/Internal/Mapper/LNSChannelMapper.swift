//
//  LNSChannelMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

typealias LNSChannelMapper = LNSChannelRequestMapper & LNSChannelResponseMapper

protocol LNSChannelRequestMapper {
    
    func requestOpenChannel(withConfig config: LNSOpenChannelConfiguration) -> Lnrpc_OpenChannelRequest
    
    func requestListChannels() -> Lnrpc_ListChannelsRequest
}

protocol LNSChannelResponseMapper {

    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint

    func map(listChannelsResponse resp: Lnrpc_ListChannelsResponse) -> [LNSChannel]
}


struct LNSChannelMapperImplementation: LNSChannelRequestMapper {
    
    func requestOpenChannel(withConfig config: LNSOpenChannelConfiguration) -> Lnrpc_OpenChannelRequest {
        var req = Lnrpc_OpenChannelRequest()
        req.nodePubkeyString = config.pubKey
        req.localFundingAmount = Int64(config.localFundingAmount)
        req.pushSat = Int64(config.remoteFundingAmount)
        req.targetConf = Int32(config.targetConfirmations)
        req.minConfs = Int32(config.minimumConfirmations)
        req.private = config.isPrivate
        if let csvDelay = config.csvDelay {
            req.remoteCsvDelay = UInt32(csvDelay)
        }
        return req
    }
    
    func requestListChannels() -> Lnrpc_ListChannelsRequest {
        return Lnrpc_ListChannelsRequest()
    }
}

extension LNSChannelMapperImplementation: LNSChannelResponseMapper {
    
    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint {
        let chanPoint = resp.chanOpen.channelPoint
        return LNSChannelPoint(fundingTransactionId: chanPoint.fundingTxidStr, outputIndex: Int(chanPoint.outputIndex))
    }
    
    func map(listChannelsResponse resp: Lnrpc_ListChannelsResponse) -> [LNSChannel] {
        return resp.channels.map {
            LNSChannel(
                id: Int($0.chanID),
                active: $0.active,
                localBalance: Int($0.localBalance),
                remoteBalance: Int($0.remoteBalance),
                capacity: Int($0.capacity),
                remotePubKey: $0.remotePubkey,
                channelPoint: $0.channelPoint,
                totalSent: Int($0.totalSatoshisSent),
                totalReceived: Int($0.totalSatoshisReceived),
                isPrivate: $0.private,
                csvDelay: Int($0.csvDelay)
            )
        }
    }
}
