//
//  LightningClientImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import SwiftProtobuf

final class LightningClientImplementation: LightningClient {
    
    let api: LightningAPI
    
    init(api: LightningAPI) {
        self.api = api
    }
    
    func request<Request, Response, Model>(
        _ request: Request,
        map: @escaping (Response) -> Model,
        completion: @escaping (Result<Model, Error>) -> Void
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        try? api.call(request: request, completion: { completion($0.map(map)) })
    }
}
