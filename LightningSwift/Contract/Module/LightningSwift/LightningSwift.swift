//
//  LightningSwift.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 13.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSCompletion = (Result<Bool, Error>) -> Void
public typealias LNSInfoCompletion = (Result<LNSInfo, Error>) -> Void

public protocol LightningSwift {
    
    var shared: LightningSwift { get }
    
    var isRunning: Bool { get }
    
    func start(withConfig: LNSConfiguration, completion: @escaping LNSCompletion)
    
    func getInfo(completion: @escaping LNSInfoCompletion)
}
