//
//  LKWallet.swift
//  LightningKit
//
//  Created by De MicheliStefano on 07.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

open class LKWallet {
    
    private enum Constants {
        static let minPasswordLength = 8
    }
    
    public static var shared: LKWallet = LKWallet()
    public var unlocked: Bool = false
    
    private let seedStore: SeedStore
    private let client: LndClient

    public convenience init() { // TODO: Add config
        self.init(
            client: LndClientBuilder().build(for: .mobile), // TODO get shared instance
            seedStore: SeedStoreImpl()
        )
    }
    
    init(client: LndClient,
         seedStore: SeedStore) {
        self.client = client
        self.seedStore = seedStore
    }
    
    // MARK: - Wallet creation
    
    /// Generates a seed with which users can recover their private keys.
    open func generateSeed(completion: @escaping (Result<LNSSeed, Error>) -> Void) {
        client.request(Lnrpc_GenSeedRequest(config: nil), map: LNSSeed.init, completion: completion)
    }
    
    /// Generates a seed with which users can recover their private keys.
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping (Result<LNSSeed, Error>) -> Void) {
        client.request(Lnrpc_GenSeedRequest(config: config), map: LNSSeed.init, completion: completion)
    }
    
    /// Creates a new wallet without a password. The password will be internally generated and saved to the Keychain.
    /// A seed will be generated and saved to the Keychain.
    open func create(completion: @escaping (Result<Void, Error>) -> Void) {
        // TODO: Generate password and store in keychain
        let password = "12345678"
        
        client.request(Lnrpc_GenSeedRequest(config: nil), map: LNSSeed.init) { [weak self] result in
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
    
    /// Creates a new wallet with a password. Password has to be minimum 8-digits long.
    /// A seed will be generated and saved to the Keychain.
    /// - Parameters:
    ///   - password: 8-digit password
    open func createWith(password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        client.request(Lnrpc_GenSeedRequest(config: nil), map: LNSSeed.init) { [weak self] result in
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
        guard password.count >= Constants.minPasswordLength else {
            return completion(Result.failure(LKWalletError.invalidPassword))
        }
        
        client.request(Lnrpc_InitWalletRequest(password: password, seed: seed), map: Bool.init(initWalletResponse:)) { result in
            switch result {
            case .success(_):
                completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    func change(password: String, toNewPassword newPassword: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        client.request(Lnrpc_ChangePasswordRequest(password: password, to: newPassword), map: Bool.init(changePasswordResponse:), completion: completion)
    }
    
    // MARK: - Wallet unlock
    
    /// Unlocks the wallet. This method needs to be called each time the apps starts.
    /// - Parameters:
    ///   - password: User's 8-digit password
    open func unlock(withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        client.request(Lnrpc_UnlockWalletRequest(password: password), map: Bool.init(unlockWalletResponse:)) { [weak self] result in
            switch result {
            case .success(_):
                self?.unlocked = true
                completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    /// Unlocks the wallet with the auto-genereated password saved in the keychain. This method needs to be called each time the apps starts.
    open func unlock(completion: @escaping (Result<Void, Error>) -> Void) {
        // TODO: Use keychain password
        return completion(Result.failure(LKError.notImplemented))
    }
    
    /// Returns the wallet's balance.
    open func getBalance(completion: @escaping (Result<LNSWalletBalance, Error>) -> Void) {
        client.request(Lnrpc_WalletBalanceRequest(), map: LNSWalletBalance.init, completion: completion)
    }
    
    /// Returns a list describing all the known transactions relevant to the wallet.
    open func getTransactions(completion: @escaping (Result<[LNSTransaction], Error>) -> Void) {
        client.request(Lnrpc_GetTransactionsRequest(), map: Array.init(transactionDetails:), completion: completion)
    }
    
    ///  Executes a request to send coins to a particular address
    open func sendCoins(withConfig config: LNSSendCoinsConfiguration, completion: @escaping (Result<LNSTransactionId, Error>) -> Void) {
        client.request(Lnrpc_SendCoinsRequest(config: config), map: LNSTransactionId.init, completion: completion)
    }
    
    ///  Creates a new address under control of the local wallet.
    func generateNewAddress(forType type: LNSAddressType, completion: @escaping (Result<BTCAddress, Error>) -> Void) {
        client.request(Lnrpc_NewAddressRequest(type: type), map: BTCAddress.init, completion: completion)
    }

    ///  Creates a new address under control of the local wallet. Default address type: p2wkh / witnessPubkeyHash
    func generateNewAddress(completion: @escaping (Result<BTCAddress, Error>) -> Void) {
        client.request(Lnrpc_NewAddressRequest(type: nil), map: BTCAddress.init, completion: completion)
    }
}
