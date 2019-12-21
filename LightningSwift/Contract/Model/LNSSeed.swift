//
//  LNSSeed.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSData

public struct LNSSeed {
    
    public let phrase: [String]
    public let encipheredSeed: Data?

    public init(phrase: [String],
                encipheredSeed: Data?) {
        self.phrase = phrase
        self.encipheredSeed = encipheredSeed
    }
}
