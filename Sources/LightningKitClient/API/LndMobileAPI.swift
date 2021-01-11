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
    
    func start(withArgs args: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        // The unlockerReady callback is called when the WalletUnlocker service is
        // ready, and rpcReady is called after the wallet has been unlocked and lnd is
        // ready to accept RPC calls. So we only wait for the unlockerReady callback.
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        let walletUnlockerCallback = LndEmptyCallback(completion)
        
        LndmobileStart(
            args,
            walletUnlockerCallback,
            LndEmptyCallback()
        )
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
