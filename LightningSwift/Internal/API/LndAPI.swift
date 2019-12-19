//
//  LightningAPI.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import SwiftProtobuf

protocol LndAPI {
    
    func call<Request, Response>(
        request: Request,
        completion: @escaping ((Result<Response, Error>) -> Void)
    ) throws where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message
}
