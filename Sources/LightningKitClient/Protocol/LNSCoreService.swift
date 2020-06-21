//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 13.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LightningSwiftService = LNSCoreService & LNSWalletService

public typealias LNSSuccessCompletion = (Result<Bool, Error>) -> Void
public typealias LNSInfoCompletion = (Result<LNSInfo, Error>) -> Void
public typealias LNSAddInvoiceCompletion = (Result<LNSInvoice, Error>) -> Void
public typealias LNSListPaymentsCompletion = (Result<[LNSPayment], Error>) -> Void
public typealias LNSListInvoicesCompletion = (Result<[LNSInvoice], Error>) -> Void

public protocol LNSCoreService {
    
    static var shared: LNSCoreService { get }
    
    var wallet: LNSWalletService { get }
    
    var channel: LNSChannelService { get }
    
    var ready: Bool { get }
    
    func start(withConfig: LNSConfiguration)
    
    func start()

    func stop()
    
    func getInfo(completion: @escaping LNSInfoCompletion)

    func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion)

    func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion)

    func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion)

    func listPayments(completion: @escaping LNSListPaymentsCompletion)
    
    func listInvoices(withRequest request: LNSListInvoicesRequest, completion: @escaping LNSListInvoicesCompletion)
    
    func connectPeer(withConfig config: LNSConnectPeerConfiguration, completion: @escaping LNSSuccessCompletion)
}
