//
//  LightningClientImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import SwiftProtobuf

final class LndClientImplementation: LndClient {
    
    let api: LndAPI
    //let argParser: LndArgumentParser
    
    init(api: LndAPI) {
        self.api = api
    }
    
    func start(withConfig: LNSConfiguration) {
        // TODO: Parse args
        // let args = argParser.parse(config: LNSConfiguration)
        api.start(withArgs: "--bitcoin.active --bitcoin.testnet --no-macaroons --bitcoin.node=neutrino")
    }
    
    func stop() {
        
    }
    
    func request<Request, Response, Model>(
        _ request: Request,
        map: @escaping (Response) -> Model,
        completion: @escaping (Result<Model, Error>) -> Void
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        try? api.call(request: request, completion: { completion($0.map(map)) })
    }
}
