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

    func mapGetInfoRequest() -> Lnrpc_GetInfoRequest
    
    func mapAddInvoiceRequest(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice

    func mapSendPaymentRequest(withRequest request: LNSPaymentRequest) -> Lnrpc_SendRequest

    func mapSendPaymentRequest(withEndcodedRequest request: LNSEncodedPaymentRequest) -> Lnrpc_SendRequest

    func mapListPaymentsRequest() -> Lnrpc_ListPaymentsRequest

    func mapConnectPeerRequest(withConnectPeerConfig config: LNSConnectPeerConfiguration) -> Lnrpc_ConnectPeerRequest
}

protocol LNSCoreResponseMapper {

    func map(getInfoResponse resp: Lnrpc_GetInfoResponse) -> LNSInfo

    func map(addInvoiceResponse response: Lnrpc_AddInvoiceResponse) -> LNSInvoice

    func map(sendPaymentResponse response: Lnrpc_SendResponse) -> Bool

    func map(sendEncodedPaymentResponse response: Lnrpc_SendResponse) -> Bool

    func map(listPaymentsResponse response: Lnrpc_ListPaymentsResponse) -> [LNSPayment]

    func map(connectPeerResponse response: Lnrpc_ConnectPeerResponse) -> Bool
}

struct LNSCoreMapperImplementation: LNSCoreRequestMapper {

    func mapGetInfoRequest() -> Lnrpc_GetInfoRequest {
        return Lnrpc_GetInfoRequest()
    }

    func mapAddInvoiceRequest(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice {
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

    func mapSendPaymentRequest(withRequest request: LNSPaymentRequest) -> Lnrpc_SendRequest {
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

    func mapSendPaymentRequest(withEndcodedRequest request: LNSEncodedPaymentRequest) -> Lnrpc_SendRequest {
        var req = Lnrpc_SendRequest()
        req.paymentRequest = request
        return req
    }
    
    func mapListPaymentsRequest() -> Lnrpc_ListPaymentsRequest {
        var req = Lnrpc_ListPaymentsRequest()
        req.includeIncomplete = false
        return req
    }
    
    func mapConnectPeerRequest(withConnectPeerConfig config: LNSConnectPeerConfiguration) -> Lnrpc_ConnectPeerRequest {
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
        return LNSInvoice( // TODO: Fix
            value: .satoshi(Int(0)),
            hash: response.rHash,
            paymentRequest: response.paymentRequest,
            creationDate: Date(),
            expiryDate:Date(),
            state: .open
        )
    }

    func map(sendPaymentResponse response: Lnrpc_SendResponse) -> Bool {
        return true
    }

    func map(sendEncodedPaymentResponse response: Lnrpc_SendResponse) -> Bool {
        return true
    }
    
    func map(listPaymentsResponse response: Lnrpc_ListPaymentsResponse) -> [LNSPayment] {
        return response.payments.map {
            LNSPayment(
                paymentHash: $0.paymentHash,
                memo: nil,
                amount: Int($0.value),
                date: Date(timeIntervalSince1970: TimeInterval($0.creationDate)),
                fees: Int($0.fee),
                preimage: $0.paymentPreimage
            )
        }
    }
    
    func map(connectPeerResponse response: Lnrpc_ConnectPeerResponse) -> Bool {
        return true
    }
}


// MARK: - Request mapping

extension Lnrpc_ListInvoiceRequest {
    
    init(request: LNSListInvoicesRequest) {
        var req = Lnrpc_ListInvoiceRequest()
        req.pendingOnly = request.pendingOnly
        req.indexOffset = UInt64(request.indexOffset)
        req.numMaxInvoices = UInt64(request.numMaxInvoices)
        req.reversed = request.reversed
    }
}


// MARK: - Response mapping

extension LNSInvoice {
    
    init(response: Lnrpc_Invoice) {
        self = .init(
            value: .satoshi(Int(response.value)),
            hash: response.rHash,
            paymentRequest: response.paymentRequest,
            creationDate: Date(timeIntervalSince1970: TimeInterval(response.creationDate)),
            expiryDate:Date(timeIntervalSince1970: TimeInterval(response.expiry)),
            state: .init(state: response.state, amountPaid: Int(response.amtPaidSat))
        )
    }
}

extension LNSInvoiceState {
    
    init(state: Lnrpc_Invoice.InvoiceState, amountPaid: Int) {
        switch state {
        case .open: self = .open
        case .settled: self = .settled(amount: .satoshi(amountPaid))
        case .canceled: self = .canceled
        case .accepted: self = .accepted
        case .UNRECOGNIZED(let code): self = .unrecognized(code)
        }
    }
}

extension Array where Element == LNSInvoice {
    
    init(listInvoice response: Lnrpc_ListInvoiceResponse) {
        self = response.invoices.map(LNSInvoice.init)
    }
}
