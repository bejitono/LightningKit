//
//  Wallet.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSInitWalletCompletion = (Result<Bool, Error>) -> Void
public typealias LNSSeedCompletion = (Result<LNSSeed, Error>) -> Void

public protocol LNSWallet {
    
    var instantiated: Bool { get }
    
    func generateSeed(completion: @escaping LNSSeedCompletion)
    
    func generateSeed(withConfig: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion)
}

enum LNSWalletError: Error {
    case alreadyCreated
}
