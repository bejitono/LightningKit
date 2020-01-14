//
//  LightningClient.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import SwiftProtobuf

protocol LndClient {
    
    func start(withConfig: LNSConfiguration)
    
    func stop()
    
    func request<Request, Response, Model>(
        _ request: Request,
        map: @escaping (Response) -> Model,
        completion: @escaping (Result<Model, Error>) -> Void
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message
}
