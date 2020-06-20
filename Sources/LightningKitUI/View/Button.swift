//
//  Button.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class Button: UIButton {
    
    public struct Model {
        public let enabledBackgroundColor: UIColor
        public let enabledForegroundColor: UIColor
        public let disabledBackgroundColor: UIColor?
        public let disabledForegroundColor: UIColor?
        public let borderColor: UIColor?
        public let shadowColor: UIColor
        public let cornerRadius: CGFloat
        public let font: UIFont
    }
    
    private let model: Model
    
    public init(model: Model = .standard) {
        self.model = model
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var isEnabled: Bool {
        didSet {
            guard let disabledBackgroundColor = model.disabledBackgroundColor else { return }
            backgroundColor = isEnabled ? model.enabledBackgroundColor : disabledBackgroundColor
        }
    }
    
    public func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }
    
    private func setupViews() {
        backgroundColor = model.enabledBackgroundColor
        setTitleColor(model.enabledForegroundColor, for: .normal)
        setTitleColor(model.disabledBackgroundColor, for: .disabled)
        layer.cornerRadius = model.cornerRadius
        applyShadow()
        if let borderColor = model.borderColor {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 1
        }
        titleLabel?.font = model.font
    }
}

public extension Button.Model {
    
    static var standard: Button.Model {
        Button.Model(
            enabledBackgroundColor: Style.Color.primaryBackground,
            enabledForegroundColor: Style.Color.primaryBackground,
            disabledBackgroundColor: Style.Color.primaryBackground,
            disabledForegroundColor: Style.Color.primaryBackground,
            borderColor: Style.Color.primaryBackground,
            shadowColor: Style.Color.primaryBackground,
            cornerRadius: 4,
            font: UIFont.systemFont(ofSize: 14)
        )
    }
}

