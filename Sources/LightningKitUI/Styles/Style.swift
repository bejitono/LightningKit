//
//  Style.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

public struct Style {
    
    public static var Color: Color = DefaultColor()
    
    public static func setup(color: Color) {
        self.Color = color
    }
}
