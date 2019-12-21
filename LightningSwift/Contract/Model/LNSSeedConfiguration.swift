//
//  LNSSeedConfiguration.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSData

public struct LNSSeedConfiguration {
    
    public let passphrase: Data
    public let entropy: Data

    public init(passphrase: Data,
                entropy: Data) {
        self.passphrase = passphrase
        self.entropy = entropy
    }
}
