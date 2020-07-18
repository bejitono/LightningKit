//
//  LNSCoreMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import LightningKitClient

// MARK: - Request mapping

extension Lnrpc_ListInvoiceRequest {
    
    init(request: LNSListInvoicesRequest) {
        var req = Lnrpc_ListInvoiceRequest()
        req.pendingOnly = request.pendingOnly
        req.indexOffset = UInt64(request.indexOffset)
        req.numMaxInvoices = UInt64(request.numMaxInvoices)
        req.reversed = request.reversed
        self = req
    }
}

extension Lnrpc_Invoice {
    
    init(request: LNSInvoiceRequest) {
        var req = Lnrpc_Invoice()
        req.value = Int64(request.amount) // TODO: sat, msat?
        req.creationDate = Int64(Date().timeIntervalSince1970)
        if let memo = request.memo,
           let timestamp = request.expiryDate?.timeIntervalSince1970 {
            req.memo = memo
            req.settleDate = Int64(timestamp)
        }
        self = req
    }
}

extension Lnrpc_ListPaymentsRequest {
    
    init(request: LNSListPaymentsRequest) {
        var req = Lnrpc_ListPaymentsRequest()
        req.includeIncomplete = request.includeIncomplete
        req.indexOffset = UInt64(request.indexOffset)
        req.maxPayments = UInt64(request.maxPayments)
        req.reversed = request.reversed
        self = req
    }
}

extension Lnrpc_SendRequest {
    
    init(request: LNSPaymentRequest) {
        var req = Lnrpc_SendRequest()
        guard
            let paymentHashData = request.paymentHash.data(using: .utf8),
            let destinationData = request.destination.data(using: .utf8)
        else {
            self = req
            return
        }
        req.paymentHash = paymentHashData
        req.dest = destinationData
        req.amt = Int64(request.amount)
        self = req
    }
}

extension Lnrpc_SendRequest {
    
    init(request: LNSEncodedPaymentRequest) {
        var req = Lnrpc_SendRequest()
        req.paymentRequest = request
        self = req
    }
}

extension Lnrpc_ConnectPeerRequest {
    
    init(request: LNSConnectPeerConfiguration) {
        var req = Lnrpc_ConnectPeerRequest()
        req.addr.pubkey = request.address.pubkey
        req.addr.host = request.address.host
        req.perm = request.permanent
        self = req
    }
}

// MARK: - Response mapping

extension LNSInfo {
    
    init(resp: Lnrpc_GetInfoResponse) {
        self.init(
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

extension LNSInvoice {
    
    init(response: Lnrpc_Invoice) {
        self.init(
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

extension Array where Element == LNSPayment {
    
    init(listPayments response: Lnrpc_ListPaymentsResponse) {
        self = response.payments.map {
            .init(
                paymentHash: $0.paymentHash,
                memo: nil,
                amount: Int($0.value),
                date: Date(timeIntervalSince1970: TimeInterval($0.creationDate)),
                fees: Int($0.fee),
                preimage: $0.paymentPreimage
            )
        }
    }
}

extension Bool {
    
    init(sendPaymentResponse: Lnrpc_SendResponse) {
        self = true
    }
    
    init(connectPeerResponse: Lnrpc_ConnectPeerResponse) {
        self = true
    }
}
