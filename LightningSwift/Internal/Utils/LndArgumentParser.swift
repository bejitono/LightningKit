//
//  LndArgumentParser.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

protocol LndArgumentParser {
    
    func parse(config: LNSConfiguration) -> String
}

struct LndArgumentParserImplementation: LndArgumentParser {
    
    func parse(config: LNSConfiguration) -> String {
        // TODO: Macaroons parsing
        return "\(config.btcEnvironment.networkDescription) --no-macaroons \(config.btcNode.configString)"
    }
}
