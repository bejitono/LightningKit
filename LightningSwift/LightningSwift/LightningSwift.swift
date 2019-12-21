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
    public let transaction: LNSTransactionService
    public let isRunning: Bool = false
    
    private let client: LndClient
    private let mapper: LNSCoreMapper

    public convenience init() {
        let lndClient = LndClientBuilder().build(.mobile)
        let serviceBuilder = LNSServiceBuilder(lndClient: lndClient)
        self.init(
            client: lndClient,
            wallet: serviceBuilder.buildWalletService(),
            transaction: serviceBuilder.buildTransactionService(),
            mapper: LNSCoreMapperImplementation()
        )
    }
    
    init(client: LndClient,
         wallet: LNSWalletService,
         transaction: LNSTransactionService,
         mapper: LNSCoreMapper) {
        self.client = client
        self.wallet = wallet
        self.transaction = transaction
        self.mapper = mapper
    }
    
    public func start(withConfig config: LNSConfiguration) throws {
        client.start(withConfig: config)
    }
    
    public func getInfo(completion: @escaping LNSInfoCompletion) {
        client.request(mapper.requestGetInfo(), map: mapper.map(getInfoResponse:), completion: completion)
    }
}
