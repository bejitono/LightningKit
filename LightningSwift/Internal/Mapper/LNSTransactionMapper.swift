//
//  LNSTransactionMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

typealias LNSTransactionMapper = LNSTransactionRequestMapper & LNSTransactionResponseMapper

protocol LNSTransactionRequestMapper {

    func requestAddInvoice(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice

    func requestSendPayment(withRequest request: LNSPaymentRequest) -> Lnrpc_SendRequest

    func requestSendPayment(withEndcodedRequest request: LNSEncodedPaymentRequest) -> Lnrpc_SendRequest
}

protocol LNSTransactionResponseMapper {

    func map(addInvoiceResponse response: Lnrpc_AddInvoiceResponse) -> LNSInvoice

    func map(sendPaymentResponse response: Lnrpc_SendResponse) -> Bool

    func map(sendEncodedPaymentResponse response: Lnrpc_SendResponse) -> Bool
}

struct LNSTransactionMapperImplementation: LNSTransactionRequestMapper {

    func requestAddInvoice(withRequest request: LNSInvoiceRequest) -> Lnrpc_Invoice {
        var req = Lnrpc_Invoice()
        req.amtPaid = Int64(request.amount) // TODO: sat, msat?
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
}

extension LNSTransactionMapperImplementation: LNSTransactionResponseMapper {

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
}
