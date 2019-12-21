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
    let argParser: LndArgumentParser
    
    init(api: LndAPI,
         argParser: LndArgumentParser) {
        self.api = api
        self.argParser = argParser
    }
    
    func start(withConfig config: LNSConfiguration) {
        let args = argParser.parse(config: config)
        api.start(withArgs: args)
    }
    
    func stop() {
        api.stop()
    }
    
    func request<Request, Response, Model>(
        _ request: Request,
        map: @escaping (Response) -> Model,
        completion: @escaping (Result<Model, Error>) -> Void
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        try? api.call(request: request, completion: { completion($0.map(map)) })
    }
}
