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
    public let channel: LNSChannelService
    public let isRunning: Bool = false
    
    private let client: LndClient
    private let mapper: LNSCoreMapper

    public convenience init() { // TODO: Add config
        let lndClient = LndClientBuilder().build(.mobile)
        let serviceBuilder = LNSServiceBuilder(lndClient: lndClient)
        self.init(
            client: lndClient,
            wallet: serviceBuilder.buildWalletService(),
            channel: serviceBuilder.buildChannelService(),
            mapper: LNSCoreMapperImplementation()
        )
    }
    
    init(client: LndClient,
         wallet: LNSWalletService,
         channel: LNSChannelService,
         mapper: LNSCoreMapper) {
        self.client = client
        self.wallet = wallet
        self.channel = channel
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
        client.request(mapper.mapGetInfoRequest(), map: mapper.map(getInfoResponse:), completion: completion)
    }

    public func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping LNSAddInvoiceCompletion) {
        client.request(mapper.mapAddInvoiceRequest(withRequest: request), map: mapper.map(addInvoiceResponse:), completion: completion)
    }

    public func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapSendPaymentRequest(withRequest: request), map: mapper.map(sendPaymentResponse:), completion: completion)
    }

    public func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapSendPaymentRequest(withEndcodedRequest: request), map: mapper.map(sendEncodedPaymentResponse:), completion: completion)
    }
    
    public func listPayments(completion: @escaping LNSListPaymentsCompletion) {
        client.request(mapper.mapListPaymentsRequest(), map: mapper.map(listPaymentsResponse:), completion: completion)
    }
    
    public func connectPeer(withConfig config: LNSConnectPeerConfiguration, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapConnectPeerRequest(withConnectPeerConfig: config), map: mapper.map(connectPeerResponse:), completion: completion)
    }
}
