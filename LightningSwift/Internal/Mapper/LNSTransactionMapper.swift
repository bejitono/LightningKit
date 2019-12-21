//
//  LNSTransactionMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

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
