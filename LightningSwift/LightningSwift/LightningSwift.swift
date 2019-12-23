//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public class LightningSwift: LNSCoreService {
    
    public static var shared: LNSCoreService = LightningSwift()
    public let wallet: LNSWalletService
    public let isRunning: Bool = false
    
    private let client: LndClient
    private let mapper: LNSCoreMapper

    public convenience init() {
        let lndClient = LndClientBuilder().build(.mobile)
        let serviceBuilder = LNSServiceBuilder(lndClient: lndClient)
        self.init(
            client: lndClient,
            wallet: serviceBuilder.buildWalletService(),
            mapper: LNSCoreMapperImplementation()
        )
    }
    
    init(client: LndClient,
         wallet: LNSWalletService,
         mapper: LNSCoreMapper) {
        self.client = client
        self.wallet = wallet
        self.mapper = mapper
    }
    
    public func start(withConfig config: LNSConfiguration) {
        client.start(withConfig: config)
    }
    
    public func start() {
        client.start(withConfig: .defaultConfig)
    }

    public func stop() {
        client.stop()
    }
    
    public func getInfo(completion: @escaping LNSInfoCompletion) {
        client.request(mapper.requestGetInfo(), map: mapper.map(getInfoResponse:), completion: completion)
    }

    public func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion) {
        client.request(mapper.requestAddInvoice(withRequest: request), map: mapper.map(addInvoiceResponse:), completion: completion)
    }

    public func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestSendPayment(withRequest: request), map: mapper.map(sendPaymentResponse:), completion: completion)
    }

    public func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestSendPayment(withEndcodedRequest: request), map: mapper.map(sendEncodedPaymentResponse:), completion: completion)
    }
    
    public func connectPeer(withConfig config: LNSConnectPeerConfiguration, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestConnectPeer(withConnectPeerConfig: config), map: mapper.map(connectPeerResponse:), completion: completion)
    }
}
