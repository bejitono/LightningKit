//
//  LNSWalletBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

struct LNSServiceBuilder {

    let lndClient: LndClient

    init(lndClient: LndClient) {
        self.lndClient = lndClient
    }

    func buildWalletService() -> LNSWalletService {
        return LNSWalletServiceImplementation(
            client: lndClient,
            mapper: LNSWalletMapperImplementation()
        )
    }

    func buildTransactionService() -> LNSTransactionService {
        return LNSTransactionServiceImplementation(
            client: lndClient,
            mapper: LNSTransactionMapperImplementation()
        )
    }
}
