//
//  LNSClientBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LndClientBuilder {
    
    public init() { }

    public func build(for type: LNSClientType) -> LndClient {
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
