//
//  Button.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol ButtonDelegate: AnyObject {
    func didTap()
}

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
    
    public weak var delegate: ButtonDelegate?
    
    private let model: Model
    
    public init(model: Model = .standard) {
        self.model = model
        super.init(frame: .zero)
        setupViews()
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
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        applyTransform(isHighlighted: true)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        applyTransform(isHighlighted: false)
    }
    
    public func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }
    
    private func setupViews() {
        backgroundColor = model.enabledBackgroundColor
        setTitleColor(model.enabledForegroundColor, for: .normal)
        setTitleColor(model.disabledForegroundColor, for: .disabled)
        layer.cornerRadius = model.cornerRadius
        applyShadow()
        if let borderColor = model.borderColor {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 1
        }
        titleLabel?.font = model.font
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
}

// MARK: Actions

extension Button {
    
    @objc func didTap() {
        delegate?.didTap()
    }
}

public extension Button.Model {
    
    static var standard: Button.Model {
        Button.Model(
            enabledBackgroundColor: Style.Color.primaryAction,
            enabledForegroundColor: Style.Color.lightText,
            disabledBackgroundColor: Style.Color.secondaryAction,
            disabledForegroundColor: Style.Color.lightText,
            borderColor: nil,
            shadowColor: Style.Color.shadow,
            cornerRadius: 4,
            font: Style.Font.subHeader
        )
    }
}
