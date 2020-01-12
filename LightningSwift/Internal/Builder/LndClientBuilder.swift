//
//  LNSClientBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

struct LndClientBuilder {

    func build(_ type: LNSClientType) -> LndClient {
        switch type {
        case .mobile: return buildMobileClient()
        default: return buildMobileClient()
        }
    }
}

private extension LndClientBuilder {
    
    func buildMobileClient() -> LndClient {
        return LndClientImplementation(
            api: LndMobileAPI(),
            argParser: LndArgumentParserImplementation()
        )
    }
}
