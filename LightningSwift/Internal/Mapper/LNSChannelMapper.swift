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
}

protocol LNSChannelResponseMapper {

    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint
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
}

extension LNSChannelMapperImplementation: LNSChannelResponseMapper {
    
    func map(openChannelResponse resp: Lnrpc_OpenStatusUpdate) -> LNSChannelPoint {
        let chanPoint = resp.chanOpen.channelPoint
        return LNSChannelPoint(fundingTransactionId: chanPoint.fundingTxidStr, outputIndex: Int(chanPoint.outputIndex))
    }
}
