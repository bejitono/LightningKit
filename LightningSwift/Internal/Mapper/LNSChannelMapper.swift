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
    
    func requestPendingChannels() -> Lnrpc_PendingChannelsRequest
}

protocol LNSChannelResponseMapper {

    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint

    func map(closeChannelResponse resp: Lnrpc_CloseStatusUpdate) -> LNSCloseChannelStatusUpdate

    func map(listChannelsResponse resp: Lnrpc_ListChannelsResponse) -> [LNSChannel]

    func map(pendingChannelsResponse resp: Lnrpc_PendingChannelsResponse) -> LNSPendingChannels
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
    
    func requestPendingChannels() -> Lnrpc_PendingChannelsRequest {
        return Lnrpc_PendingChannelsRequest()
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
    
    func map(pendingChannelsResponse resp: Lnrpc_PendingChannelsResponse) -> LNSPendingChannels {
        let pendingOpenChannels = resp.pendingOpenChannels.map { map(pendingChannel: $0.channel) }
        let pendingClosingChannels = resp.pendingClosingChannels.map {
            LNSPendingCloseChannel(pendingChannel: map(pendingChannel: $0.channel), closingTxId: $0.closingTxid)
        }
        let pendingForceClosingChannels = resp.pendingForceClosingChannels.map {
            LNSPendingCloseChannel(pendingChannel: map(pendingChannel: $0.channel), closingTxId: $0.closingTxid)
        }
        let waitingCloseChannels = resp.waitingCloseChannels.map { map(pendingChannel: $0.channel) }
        return LNSPendingChannels(
            pendingOpenChannels: pendingOpenChannels,
            pendingClosingChannels: pendingClosingChannels,
            pendingForceClosingChannels: pendingForceClosingChannels,
            waitingCloseChannels: waitingCloseChannels
        )
    }
}

private extension LNSChannelMapperImplementation {
    
    func map(pendingChannel: Lnrpc_PendingChannelsResponse.PendingChannel)  -> LNSPendingChannel {
        return LNSPendingChannel(
            remoteNodePubKey: pendingChannel.remoteNodePub,
            channelPoint: pendingChannel.channelPoint,
            capacity: Int(pendingChannel.capacity),
            localBalance: Int(pendingChannel.localBalance),
            remoteBalance: Int(pendingChannel.remoteBalance)
        )
    }
}
