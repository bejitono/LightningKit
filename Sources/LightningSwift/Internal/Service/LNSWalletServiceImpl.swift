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
        client.request(mapper.mapGenerateSeedRequest(withConfig: nil), map: mapper.map(seedResponse:), completion: completion)
    }
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) {
        client.request(mapper.mapGenerateSeedRequest(withConfig: config), map: mapper.map(seedResponse:), completion: completion)
    }
    
    func initializeWalletWith(password: String, seed: [String], completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapInitWalletRequestWith(password: password, seed: seed), map: mapper.map(initWalletResponse:), completion: completion)
    }
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapUnlockWalletRequest(withPassword: password), map: mapper.map(unlockWalletResponse:), completion: completion)
    }
    
    func changeWallet(password: String, to newPassword: String, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.mapChangeRequest(password: password, to: newPassword), map: mapper.map(changePasswordResponse:), completion: completion)
    }
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion) {
        client.request(mapper.mapWalletBalanceRequest(), map: mapper.map(walletBalanceResponse:), completion: completion)
    }
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion) {
        client.request(mapper.mapChannelBalanceRequest(), map: mapper.map(channelBalanceResponse:), completion: completion)
    }
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion) {
        client.request(mapper.mapTransactionsRequest(), map: mapper.map(transactionsResponse:), completion: completion)
    }
    
    func generateNewAddress(forType type: LNSAddressType, completion: @escaping LNSNewAddressCompletion) {
        client.request(mapper.mapNewAddressRequest(forType: type), map: mapper.map(newAddressResponse:), completion: completion)
    }
    
    // Default: p2wkh / witnessPubkeyHash
    func generateNewAddress(completion: @escaping LNSNewAddressCompletion) {
        client.request(mapper.mapNewAddressRequest(forType: nil), map: mapper.map(newAddressResponse:), completion: completion)
    }
    
    func sendCoins(withConfig config: LNSSendCoinsConfiguration, completion: @escaping LNSSendCoinsCompletion) {
        client.request(mapper.mapSendCoinsRequest(withConfig: config), map: mapper.map(sendCoinsResponse:), completion: completion)
    }
}
