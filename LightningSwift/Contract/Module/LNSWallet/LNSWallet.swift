//
//  Wallet.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSData

public typealias LNSInitWalletCompletion = (Result<Bool, Error>) -> Void
public typealias LNSWalletSeedCompletion = (Result<LNSSeed, Error>) -> Void

public protocol LNSWallet {
    
    var instantiated: Bool { get }
    
    func generateSeed(completion: @escaping LNSWalletSeedCompletion)
    
    func generateSeed(withConfig: LNSSeedConfiguration, completion: @escaping LNSWalletSeedCompletion)
}

public struct LNSSeedConfiguration {
    
    let passphrase: String
    let entropy: Data
}

public struct LNSSeed {
    
    let phrase: [String]
    let encipheredSeed: Data?
}

enum LNSWalletError: Error {
    case alreadyCreated
}
