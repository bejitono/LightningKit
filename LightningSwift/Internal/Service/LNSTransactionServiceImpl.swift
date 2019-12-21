//
//  LNSTransactionServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSTransactionServiceImplementation: LNSTransactionService {

    private let client: LndClient
    private let mapper: LNSTransactionMapper

    init(client: LndClient,
         mapper: LNSTransactionMapper) {
        self.client = client
        self.mapper = mapper
    }

    func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion) {
        client.request(mapper.requestAddInvoice(withRequest: request), map: mapper.map(addInvoiceResponse:), completion: completion)
    }

    func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestSendPayment(withRequest: request), map: mapper.map(sendPaymentResponse:), completion: completion)
    }

    func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestSendPayment(withEndcodedRequest: request), map: mapper.map(sendEncodedPaymentResponse:), completion: completion)
    }
}
