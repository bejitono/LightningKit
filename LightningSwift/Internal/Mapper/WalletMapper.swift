//
//  WalletMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

protocol WalletRequestMapper {
    
    func request(config: LNSSeedConfiguration) -> Lnrpc_GenSeedRequest
    
    func request(password: String, seed: LNSSeed) -> Lnrpc_InitWalletRequest
    
    func request(password: String, newPassword: String) -> Lnrpc_ChangePasswordRequest
    
    func request() -> Lnrpc_WalletBalanceRequest
    
    func request() -> Lnrpc_ChannelBalanceRequest
    
    func request() -> Lnrpc_GetTransactionsRequest
}

struct WalletMapperImplementation: WalletRequestMapper {
    
    func request(config: LNSSeedConfiguration) -> Lnrpc_GenSeedRequest {
        var req = Lnrpc_GenSeedRequest()
        req.aezeedPassphrase = config.passphrase
        req.seedEntropy = config.entropy
        return req
    }
    
    func request(password: String, seed: LNSSeed) -> Lnrpc_InitWalletRequest {
        var req = Lnrpc_InitWalletRequest()
        guard let passwordData = password.data(using: .utf8) else { return req }
        req.walletPassword = passwordData
        req.cipherSeedMnemonic = seed.phrase
        if let encipheredSeed = seed.encipheredSeed { req.aezeedPassphrase = encipheredSeed }
        return req
    }
    
    func request(password: String, newPassword: String) -> Lnrpc_ChangePasswordRequest {
        var req = Lnrpc_ChangePasswordRequest()
        guard
            let passwordData = password.data(using: .utf8),
            let newPasswordData = newPassword .data(using: .utf8)
        else { return req }
        req.currentPassword = passwordData
        req.newPassword = newPasswordData
        return req
    }
    
    func request() -> Lnrpc_WalletBalanceRequest {
        return Lnrpc_WalletBalanceRequest()
    }
    
    func request() -> Lnrpc_ChannelBalanceRequest {
        return Lnrpc_ChannelBalanceRequest()
    }
    
    func request() -> Lnrpc_GetTransactionsRequest {
        return Lnrpc_GetTransactionsRequest()
    }
}
