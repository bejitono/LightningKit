//
//  LNSChannel.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 29.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public struct Channel {
    
    public let id: String
    public let active: Bool
    public let localBalance: Int
    public let remoteBalance: Int
    public let capacity: Int
    public let remotePubKey: String
    public let channelPoint: String // TODO: Use Channel Point model
    public let blockHeight: Int
    public let totalSent: Int
    public let totalReceived: Int
    public let isPrivate: Bool
    public let csvDelay: Int
    public let closeAddress: String
}
