//
//  LNSTransactionServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSTransactionServiceImplementation: LNSTransactionService {

    private let client: LndClient
    private let mapper: LNSWalletMapper

    init(client: LndClient,
         mapper: LNSWalletMapper) {
        self.client = client
        self.mapper = mapper
    }

    func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion) {

    }

    func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion) {

    }

    func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion) {

    }
}
