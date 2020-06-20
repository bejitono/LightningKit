//
//  Color.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit
    
public struct DefaultColor: Color {
    
    public var primaryBackground: UIColor = .white
    public var primaryAction: UIColor = UIColor.rgb(red: 47, green: 157, blue: 254)
    public var primaryText: UIColor = UIColor.rgb(red: 0, green: 52, blue: 89)
    public var secondaryBackground: UIColor = UIColor.rgb(red: 36, green: 36, blue: 36)
    public var secondaryAction: UIColor = UIColor.rgb(red: 59, green: 206, blue: 172)
    public var secondaryText: UIColor = .white
    public var lightText: UIColor = .white
    public var alert: UIColor = UIColor.rgb(red: 226, green: 17, blue: 58)
    public var success: UIColor = UIColor.rgb(red: 76, green: 185, blue: 68)
    public var failure: UIColor = UIColor.rgb(red: 254, green: 95, blue: 85)
    public var shadow: UIColor = .lightGray
    public var disabled: UIColor = .lightGray
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
