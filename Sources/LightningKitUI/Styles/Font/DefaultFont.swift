//
//  DefaultFont.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 20.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public struct DefaultFont: Font {
    
    public let header = UIFont.boldSystemFont(ofSize: 24)
    public let subHeader = UIFont.boldSystemFont(ofSize: 18)
    public let bodyLarge = UIFont.systemFont(ofSize: 16)
    public let bodyRegular = UIFont.systemFont(ofSize: 14)
    public let bodySmall = UIFont.systemFont(ofSize: 12)
}
