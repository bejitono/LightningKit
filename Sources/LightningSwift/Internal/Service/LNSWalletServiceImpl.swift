//
//  LNSWalletServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSWalletServiceImplementation: LNSWalletService {
    
    var initialized: Bool = false
    var unlocked: Bool = false
    
    private let client: LndClient
    private let mapper: LNSWalletMapper
    
    init(client: LndClient,
         mapper: LNSWalletMapper) {
        self.client = client
        self.mapper = mapper
    }
    
    func generateSeed(completion: @escaping LNSSeedCompletion) {
        client.request(Lnrpc_GenSeedRequest(config: nil), map: mapper.map(seedResponse:), completion: completion)
    }
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) {
        client.request(Lnrpc_GenSeedRequest(config: config), map: LNSSeed.init, completion: completion)
    }
    
    func initializeWalletWith(password: String, seed: [String], completion: @escaping LNSSuccessCompletion) {
        client.request(Lnrpc_InitWalletRequest(password: password, seed: seed), map: mapper.map(initWalletResponse:), completion: completion)
    }
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSSuccessCompletion) {
        client.request(Lnrpc_UnlockWalletRequest(password: password), map: mapper.map(unlockWalletResponse:), completion: completion)
    }
    
    func changeWallet(password: String, to newPassword: String, completion: @escaping LNSSuccessCompletion) {
        client.request(Lnrpc_ChangePasswordRequest(password: password, to: newPassword), map: mapper.map(changePasswordResponse:), completion: completion)
    }
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion) {
        client.request(Lnrpc_WalletBalanceRequest(), map: mapper.map(walletBalanceResponse:), completion: completion)
    }
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion) {
        client.request(Lnrpc_ChannelBalanceRequest(), map: mapper.map(channelBalanceResponse:), completion: completion)
    }
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion) {
        client.request(Lnrpc_GetTransactionsRequest(), map: mapper.map(transactionsResponse:), completion: completion)
    }
    
    func generateNewAddress(forType type: LNSAddressType, completion: @escaping LNSNewAddressCompletion) {
        client.request(Lnrpc_NewAddressRequest(type: type), map: mapper.map(newAddressResponse:), completion: completion)
    }
    
    // Default: p2wkh / witnessPubkeyHash
    func generateNewAddress(completion: @escaping LNSNewAddressCompletion) {
        client.request(Lnrpc_NewAddressRequest(type: nil), map: mapper.map(newAddressResponse:), completion: completion)
    }
    
    func sendCoins(withConfig config: LNSSendCoinsConfiguration, completion: @escaping LNSSendCoinsCompletion) {
        client.request(Lnrpc_SendCoinsRequest(config: config), map: mapper.map(sendCoinsResponse:), completion: completion)
    }
}
