//
//  LightningMobileAPI.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Lndmobile
import SwiftProtobuf

final class LightningMobileAPI: LightningAPI {

    func call<Request, Response>(
        request: Request,
        completion: @escaping ((Result<Response, Error>) -> Void)
    ) throws where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        try? request.send(completion: completion)
    }
}

private extension SwiftProtobuf.Message {
    
    func send<Response>(completion: @escaping (Result<Response, Error>) -> Void) throws where Response: SwiftProtobuf.Message {
        switch self {
        case is Lnrpc_ListPeersRequest: LndmobileListPeers(try? self.serializedData(), LightningCallback(completion))
        default: throw LightningError.requestUnkown
        }
    }
}
