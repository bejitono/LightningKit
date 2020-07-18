//
//  LightningAPI.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import SwiftProtobuf

protocol LndAPI {
    
    func start(withArgs args: String?)
    
    func stop()
    
    func call<Request, Response>(
        request: Request,
        completion: @escaping ((Result<Response, Error>) -> Void)
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message
}
