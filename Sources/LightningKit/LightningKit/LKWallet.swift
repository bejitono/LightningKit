//
//  LKWallet.swift
//  LightningKit
//
//  Created by De MicheliStefano on 07.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import LightningSwift

public typealias Seed = [String]

open class LKWallet {
    
    private enum Constants {
        static let minPasswordLength = 8
    }
    
    public var unlocked: Bool = false
    
    private var seed: Seed?
    private let client: LNSCoreService
    
    init(client: LNSCoreService = LightningSwift.shared) {
        self.client = client
        // TODO: Add config: seedless, no password
    }
    
    /// Generates a seed with which users can recover their private keys.
    open func generateSeed(completion: @escaping (Result<Seed, Error>) -> Void) {
        client.wallet.generateSeed { [weak self] result in
            switch result {
            case .success(let seed):
                self?.seed = seed.phrase
                completion(Result.success(seed.phrase))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    /// Creates a new wallet without a password. The password will be internall genrated and saved on the device.
    open func create(completion: @escaping (Result<Void, Error>) -> Void) {
        return completion(Result.failure(LKError.notImplemented))
    }
    
    /// Creates a new wallet without a password. Password has to be minimum 8-digits long.
    /// - Parameters:
    ///   - password: 8-digit password
    open func create(password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !client.ready else {
            return completion(Result.failure(LKError.lightningNodeNotReady))
        }
        
        guard password.count > Constants.minPasswordLength else {
            return completion(Result.failure(LKWalletError.invalidPassword))
        }
        
        guard let seed = seed else {
            return completion(Result.failure(LKWalletError.seedNotGenerated))
        }
        
        client.wallet.initializeWith(password: password, seed: seed) { result in
            switch result {
            case .success(_): completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    /// Unlocks the wallet. This method needs to be called each time the apps starts.
    /// - Parameters:
    ///   - password: User's 8-digit password
    open func unlock(withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        client.wallet.unlock(withPassword: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.unlocked = true
                completion(Result.success(()))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    /// Unlocks the wallet with the auto-genereated password saved in the keychain. This method needs to be called each time the apps starts.
    open func unlock(completion: @escaping (Result<Void, Error>) -> Void) {
        return completion(Result.failure(LKError.notImplemented))
    }
}
