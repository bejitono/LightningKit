//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public class LightningSwift: LightningSwiftCore {
    
    //public let shared: LightningSwiftCore = LightningSwift()
    public let wallet: LNSWalletService
    public let isRunning: Bool = false
    
    private let client: LndClient
    
    init(client: LndClient,
         wallet: LNSWalletService) {
        self.client = client
        self.wallet = wallet
    }
    
    public func start(withConfig config: LNSConfiguration) throws {
        client.start(withConfig: config)
    }
    
    public func getInfo(completion: @escaping LNSInfoCompletion) {
        
    }
}
