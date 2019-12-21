//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 13.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LightningSwiftService = LNSCoreService & LNSWalletService & LNSTransactionService

public typealias LNSSuccessCompletion = (Result<Bool, Error>) -> Void
public typealias LNSInfoCompletion = (Result<LNSInfo, Error>) -> Void

public protocol LNSCoreService {
    
    static var shared: LNSCoreService { get }
    
    var wallet: LNSWalletService { get }

    var transaction: LNSTransactionService { get }
    
    var isRunning: Bool { get }
    
    func start(withConfig: LNSConfiguration) throws

    func stop() throws
    
    func getInfo(completion: @escaping LNSInfoCompletion)
}
