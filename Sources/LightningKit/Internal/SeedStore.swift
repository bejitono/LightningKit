//
//  SeedStorage.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 18.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import Foundation
import KeychainAccess

protocol SeedStore {
    
    func set(_ seed: [String]) throws
    func get() -> [String]?
}

final class SeedStoreImpl: SeedStore {
    
    private let keychain: Keychain
    private let key: String = "seed"
    
    init(service: String = "com.LightningKit.LightningKit") {
        self.keychain = Keychain(service: service)
    }
    
    func set(_ seed: [String]) throws {
        let seedData = try NSKeyedArchiver.archivedData(withRootObject: seed, requiringSecureCoding: true)
        try keychain.set(seedData, key: key)
    }
    
    func get() -> [String]? {
        guard let seedData = try? keychain.getData(key) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: seedData) as? [String]
    }
}
