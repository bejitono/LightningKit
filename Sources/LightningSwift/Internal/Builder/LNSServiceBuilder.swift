//
//  LNSWalletBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

struct LNSServiceBuilder {

    private let lndClient: LndClient

    init(lndClient: LndClient) {
        self.lndClient = lndClient
    }

    func buildWalletService() -> LNSWalletService {
        return LNSWalletServiceImplementation(client: lndClient)
    }

    func buildChannelService() -> LNSChannelService {
        return LNSChannelServiceImplementation(client: lndClient)
    }
}
