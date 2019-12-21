//
//  LNSWalletBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

struct LNSServiceBuilder {

    let lndClientBuilder: LndClientBuilder

    func buildWalletService() -> LNSWalletService {
        return LNSWalletServiceImplementation(
            client: lndClientBuilder.build(.mobile),
            mapper: LNSWalletMapperImplementation()
        )
    }
}
