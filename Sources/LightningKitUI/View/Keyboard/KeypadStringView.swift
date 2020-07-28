//
//  KeypadStringView.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 28.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol KeypadStringViewDelegate: AnyObject {
    func didTap(string: String)
}

open class KeypadStringView: KeypadView {
    
    public let string: String
    public weak var delegate: KeypadStringViewDelegate?
    
    init(string: String) {
        self.string = string
        super.init()
        setupStringView()
        tapBlock = { self.delegate?.didTap(string: string) }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStringView() {
        let stringLabel = UILabel()
        stringLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stringLabel)
        NSLayoutConstraint.activate([
            stringLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            stringLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stringLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stringLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        stringLabel.font = UIFont.systemFont(ofSize: 40)
        stringLabel.text = string
        stringLabel.textColor = Style.Color.primaryText
        stringLabel.textAlignment = .center
    }
}
