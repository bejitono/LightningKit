//
//  LightningMobileAPI.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Lndmobile
import SwiftProtobuf

final class LndMobileAPI: LndAPI {
    
    func start(withArgs args: String?) {
        // TODO: Change as it will have two callbacks:
        // once when wallet unlocker is ready, and once rpcserver is ready
        // TODO: Add completion closure for when lnd has started
        LndmobileStart(args, LndEmptyCallback(), LndEmptyCallback())
    }
    
    func stop() {
        LndmobileStopDaemon(try? Lnrpc_StopRequest().serializedData(), LndEmptyCallback())
    }
    
    func call<Request, Response>(
        request: Request,
        completion: @escaping ((Result<Response, Error>) -> Void)
    ) where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        do {
            try request.send(completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
