//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 13.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSInfoCompletion = (Result<LNSInfo, LNSError>) -> Void

public protocol LightningSwift {
    
    var shared: LightningSwift { get }
    
    var wallet: LNSWallet { get }
    
    var isRunning: Bool { get }
    
    func start(withConfig: LNSConfiguration) throws
    
    func getInfo(completion: @escaping LNSInfoCompletion)
}
