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
        return "--bitcoin.active \(config.btcEnvironment.argumentString) --no-macaroons \(config.btcNode.argumentString) --autopilot.active --autopilot.allocation=0.8 --routing.assumechanvalid --listen=0.0.0.0:9735" //--debuglevel=debug
    }
}
