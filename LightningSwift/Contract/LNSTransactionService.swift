//
//  LNSTransaction.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSAddInvoiceCompletion = (Result<LNSInvoice, Error>) -> Void

protocol LNSTransactionService {
    
    func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion)
    
    func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion)
    
    func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion)
}
