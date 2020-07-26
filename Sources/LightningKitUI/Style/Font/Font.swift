//
//  Font.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 20.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol Font {
    var header: UIFont { get }
    var subHeader: UIFont { get }
    var bodyLarge: UIFont { get }
    var bodyRegular: UIFont { get }
    var bodySmall: UIFont { get }
}
