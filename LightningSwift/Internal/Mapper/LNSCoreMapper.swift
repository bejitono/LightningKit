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
    
    func requestAddInvoice(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice

    func requestSendPayment(withRequest request: LNSPaymentRequest) -> Lnrpc_SendRequest

    func requestSendPayment(withEndcodedRequest request: LNSEncodedPaymentRequest) -> Lnrpc_SendRequest

    func requestConnectPeer(withConnectPeerConfig config: LNSConnectPeerConfiguration) -> Lnrpc_ConnectPeerRequest
}

protocol LNSCoreResponseMapper {

    func map(getInfoResponse resp: Lnrpc_GetInfoResponse) -> LNSInfo

    func map(addInvoiceResponse response: Lnrpc_AddInvoiceResponse) -> LNSInvoice

    func map(sendPaymentResponse response: Lnrpc_SendResponse) -> Bool

    func map(sendEncodedPaymentResponse response: Lnrpc_SendResponse) -> Bool

    func map(connectPeerResponse response: Lnrpc_ConnectPeerResponse) -> Bool
}

struct LNSCoreMapperImplementation: LNSCoreRequestMapper {

    func requestGetInfo() -> Lnrpc_GetInfoRequest {
        return Lnrpc_GetInfoRequest()
    }

    func requestAddInvoice(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice {
        var req = Lnrpc_Invoice()
        req.value = Int64(request.amount) // TODO: sat, msat?
        req.creationDate = Int64(Date().timeIntervalSince1970)
        if let memo = request.memo,
           let timestamp = request.expiryDate?.timeIntervalSince1970 {
            req.memo = memo
            req.settleDate = Int64(timestamp)
        }
        return req
    }

    func requestSendPayment(withRequest request: LNSPaymentRequest) -> Lnrpc_SendRequest {
        var req = Lnrpc_SendRequest()
        guard
            let paymentHashData = request.paymentHash.data(using: .utf8),
            let destinationData = request.destination.data(using: .utf8)
            else { return req }
        req.paymentHash = paymentHashData
        req.dest = destinationData
        req.amt = Int64(request.amount)
        return req
    }

    func requestSendPayment(withEndcodedRequest request: LNSEncodedPaymentRequest) -> Lnrpc_SendRequest {
        var req = Lnrpc_SendRequest()
        req.paymentRequest = request
        return req
    }
    
    func requestConnectPeer(withConnectPeerConfig config: LNSConnectPeerConfiguration) -> Lnrpc_ConnectPeerRequest {
        var req = Lnrpc_ConnectPeerRequest()
        req.addr.pubkey = config.address.pubkey
        req.addr.host = config.address.host
        req.perm = config.permanent
        return req
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

    func map(addInvoiceResponse response: Lnrpc_AddInvoiceResponse) -> LNSInvoice {
        return LNSInvoice(
            hash: response.rHash,
            paymentRequest: response.paymentRequest,
            timestamp: Date(), // TODO
            expiryDate: Date(), // TODO
            state: .open //TODO
        )
    }

    func map(sendPaymentResponse response: Lnrpc_SendResponse) -> Bool {
        return true
    }

    func map(sendEncodedPaymentResponse response: Lnrpc_SendResponse) -> Bool {
        return true
    }
    
    func map(connectPeerResponse response: Lnrpc_ConnectPeerResponse) -> Bool {
        return true
    }
}
