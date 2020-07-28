//
//  KeypadImageView.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 28.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol KeypadImageViewDelegate: AnyObject {
    func didTapImage() // TODO: Change to enum
}

open class KeypadImageView: KeypadView {
    
    public let image: UIImage
    public weak var delegate: KeypadImageViewDelegate?
    
    init(image: UIImage) {
        self.image = image
        super.init()
        setupImageView()
        tapBlock = { self.delegate?.didTapImage() }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        let image = UIImageView(image: self.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        image.tintColor = Style.Color.primaryText
    }
}
