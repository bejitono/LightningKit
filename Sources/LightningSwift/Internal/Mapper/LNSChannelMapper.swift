//
//  LNSChannelMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

// - MARK: Request mapping

extension Lnrpc_OpenChannelRequest {
    
    init(config: LNSOpenChannelConfiguration) {
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
        self = req
    }
}

extension Lnrpc_CloseChannelRequest {
    
    init(config: LNSCloseChannelConfiguration) {
        var req = Lnrpc_CloseChannelRequest()
        var channelPoint = Lnrpc_ChannelPoint()
        channelPoint.outputIndex = UInt32(config.channelPoint.outputIndex)
        channelPoint.fundingTxidStr = config.channelPoint.fundingTransactionId
        req.channelPoint = channelPoint
        req.force = config.isForced
        req.targetConf = Int32(config.targetConfirmations)
        self = req
    }
}

// - MARK: Response mapping

extension LNSChannelPoint {
    
    init(response: Lnrpc_OpenStatusUpdate) {
        let chanPoint = response.chanOpen.channelPoint
        self.init(
            fundingTransactionId: chanPoint.fundingTxidStr,
            outputIndex: Int(chanPoint.outputIndex)
        )
    }
}

extension LNSCloseChannelStatusUpdate {
    
    init(response: Lnrpc_CloseStatusUpdate) {
        guard let update = response.update else { self = .pending; return }
        switch update {
        case .closePending: self = .pending
        case .chanClose: self = .closed
        }
    }
}

extension Array where Element == LNSChannel {
    
    init(channelsResponse: Lnrpc_ListChannelsResponse) {
        self = channelsResponse.channels.map {
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

extension LNSPendingChannels {
    
    init(response: Lnrpc_PendingChannelsResponse) {
        let pendingOpenChannels = response.pendingOpenChannels.map { map(pendingChannel: $0.channel) }
        let pendingClosingChannels = response.pendingClosingChannels.map {
            LNSPendingCloseChannel(pendingChannel: map(pendingChannel: $0.channel), closingTxId: $0.closingTxid)
        }
        let pendingForceClosingChannels = response.pendingForceClosingChannels.map {
            LNSPendingCloseChannel(pendingChannel: map(pendingChannel: $0.channel), closingTxId: $0.closingTxid)
        }
        let waitingCloseChannels = response.waitingCloseChannels.map { map(pendingChannel: $0.channel) }
        self.init(
            pendingOpenChannels: pendingOpenChannels,
            pendingClosingChannels: pendingClosingChannels,
            pendingForceClosingChannels: pendingForceClosingChannels,
            waitingCloseChannels: waitingCloseChannels
        )
    }
}

private func map(pendingChannel: Lnrpc_PendingChannelsResponse.PendingChannel)  -> LNSPendingChannel {
    return LNSPendingChannel(
        remoteNodePubKey: pendingChannel.remoteNodePub,
        channelPoint: pendingChannel.channelPoint,
        capacity: Int(pendingChannel.capacity),
        localBalance: Int(pendingChannel.localBalance),
        remoteBalance: Int(pendingChannel.remoteBalance)
    )
}
