//
//  LKWallet.swift
//  LightningKit
//
//  Created by De MicheliStefano on 07.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import LightningKitClient

public typealias Seed = [String]

open class LKWallet {
    
    private enum Constants {
        static let minPasswordLength = 8
    }
    
    public var unlocked: Bool = false
    
    private let seedStore: SeedStore
    private let client: LNSCoreService
    
    public convenience init(client: LNSCoreService = LightningKitClient.shared) {
        self.init(client: client)
        // TODO: Add config: seedless, no password
    }
    
    init(client: LNSCoreService,
         seedStore: SeedStore = SeedStoreImpl()) {
        self.client = client
        self.seedStore = seedStore
    }
    
    // MARK: - Wallet creation
    
    /// Generates a seed with which users can recover their private keys.
    open func generateSeed(completion: @escaping (Result<Seed, Error>) -> Void) {
        client.wallet.generateSeed { result in
            switch result {
            case .success(let seed):
                completion(Result.success(seed.phrase))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    /// Creates a new wallet without a password. The password will be internally generated and saved to the Keychain.
    /// A seed will be generated and saved to the Keychain.
    open func create(completion: @escaping (Result<Void, Error>) -> Void) {
        // TODO: Generate password and store in keychain
        let password = "12345678"
        
        client.wallet.generateSeed { [weak self] result in
            switch result {
            case .success(let seed):
                do {
                    try self?.seedStore.set(seed.phrase) // Enciphered seed instead?
                    self?.createWith(password: password, seed: seed.phrase) { result in
                        switch result {
                        case .success(_): completion(Result.success(()))
                        case .failure(let error): completion(Result.failure(error))
                        }
                    }
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    /// Creates a new wallet without a password. Password has to be minimum 8-digits long.
    /// A seed will be generated and saved to the Keychain.
    /// - Parameters:
    ///   - password: 8-digit password
    open func createWith(password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        client.wallet.generateSeed { [weak self] result in
            switch result {
            case .success(let seed):
                do {
                    try self?.seedStore.set(seed.phrase) // Enciphered seed instead?
                    self?.createWith(password: password, seed: seed.phrase) { result in
                        switch result {
                        case .success(_): completion(Result.success(()))
                        case .failure(let error): completion(Result.failure(error))
                        }
                    }
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    /// Creates a new wallet without a password. Password has to be minimum 8-digits long.
    /// - Parameters:
    ///   - password: 8-digit password
    ///   - seed: Seed generated with generateSeed(completion:)
    open func createWith(password: String, seed: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        guard !client.ready else {
            return completion(Result.failure(LKError.lightningNodeNotReady))
        }
        
        guard password.count > Constants.minPasswordLength else {
            return completion(Result.failure(LKWalletError.invalidPassword))
        }
        
        client.wallet.initializeWith(password: password, seed: seed) { result in
            switch result {
            case .success(_): completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    // MARK: - Wallet unlock
    
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
    
    open func getBalance(completion: @escaping (Result<LNSWalletBalance, Error>) -> Void) {
        client.wallet.getWalletBalance { (result) in
            switch result {
            case .success(let balance):
                completion(Result.success(balance))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
