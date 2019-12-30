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
    
    func requestCloseChannel(withConfig config: LNSCloseChannelConfiguration) -> Lnrpc_CloseChannelRequest
    
    func requestListChannels() -> Lnrpc_ListChannelsRequest
}

protocol LNSChannelResponseMapper {

    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint

    func map(closeChannelResponse resp: Lnrpc_CloseStatusUpdate) -> LNSCloseChannelStatusUpdate

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
    
    func requestCloseChannel(withConfig config: LNSCloseChannelConfiguration) -> Lnrpc_CloseChannelRequest {
        var req = Lnrpc_CloseChannelRequest()
        var channelPoint = Lnrpc_ChannelPoint()
        channelPoint.outputIndex = UInt32(config.channelPoint.outputIndex)
        channelPoint.fundingTxidStr = config.channelPoint.fundingTransactionId
        req.channelPoint = channelPoint
        req.force = config.isForced
        req.targetConf = Int32(config.targetConfirmations)
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
    
    func map(closeChannelResponse resp: Lnrpc_CloseStatusUpdate) -> LNSCloseChannelStatusUpdate {
        guard let update = resp.update else { return .pending }
        switch update {
        case .closePending: return .pending
        case .chanClose: return .closed
        }
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
