//
//  LNSClientBuilder.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct LndClientBuilder {
    
    var mobileClient: LndClient {
        LndClientImplementation(
            api: LndMobileAPI(),
            argParser: LndArgumentParserImplementation()
        )
    }
    
    public init() { }

    public func build(for type: LNSClientType) -> LndClient {
        switch type {
        case .mobile: return mobileClient
        default: return mobileClient
        }
    }
}
