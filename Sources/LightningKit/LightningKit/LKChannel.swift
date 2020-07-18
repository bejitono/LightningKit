//
//  LKChannel.swift
//  LightningKit
//
//  Created by De MicheliStefano on 07.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import LightningKitClient

open class LKChannel {
    
    private let client: LNSCoreService
    
    public init(client: LNSCoreService = LightningKitClient.shared) {
        self.client = client
        // TODO: Add config: seedless, no password
    }
    
    /// Generates a seed with which users can recover their private keys.
    open func getInfo(completion: @escaping (Result<LNSInfo, Error>) -> Void) {
        client.getInfo { (result) in
            switch result {
            case .success(let info):
                completion(Result.success(info))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
