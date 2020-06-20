//
//  Color.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol Color {
    
    var primary: UIColor { get }
    var primaryBackground: UIColor { get }
    var primaryAction: UIColor { get }
    var primaryText: UIColor { get }
    var secondary: UIColor { get }
    var secondaryBackground: UIColor { get }
    var secondaryAction: UIColor { get }
    var secondaryText: UIColor { get }
    var lightText: UIColor { get }
    var alert: UIColor { get }
    var success: UIColor { get }
    var failure: UIColor { get }
    var shadow: UIColor { get }
    var disabled: UIColor { get }
}
