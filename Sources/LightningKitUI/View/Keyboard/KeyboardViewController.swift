//
//  KeyboardViewController.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 28.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol KeyboardViewControllerDelegate: AnyObject {
    func didTap(digit: Int)
    func didTapDot()
    func didTapDelete()
}

open class KeyboardViewController: UIViewController {
    
    public weak var delegate: KeyboardViewControllerDelegate?
    
    private enum ViewConstants {
        static let spacing: CGFloat = 8
        static let buttonHeight: CGFloat = 45
    }
    
    private let containerStackView = UIStackView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - View Setup

private extension KeyboardViewController {

    func setupViews() {
        view.backgroundColor = Style.Color.primaryBackground
        setupContainerStackView()
        setupKeypadViews()
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.topAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        containerStackView.axis = .vertical
        containerStackView.spacing = ViewConstants.spacing
        containerStackView.distribution = .fillEqually
    }
    
    func setupKeypadViews() {
        containerStackView.addArrangedSubview(keypadViewsFor(range: 1...3))
        containerStackView.addArrangedSubview(keypadViewsFor(range: 4...6))
        containerStackView.addArrangedSubview(keypadViewsFor(range: 7...9))
        containerStackView.addArrangedSubview(lowerKeypadViews())
    }
    
    func keypadViewsFor(range: ClosedRange<Int>) -> UIStackView {
        let row = rowStackView()
        for digit in range {
            let keypadView = KeypadDigitView(digit: digit)
            keypadView.delegate = self
            row.addArrangedSubview(keypadView)
        }
        return row
    }
    
    func lowerKeypadViews() -> UIStackView {
        let row = rowStackView()
        let dotKeypadView = KeypadStringView(string: ".")
        dotKeypadView.delegate = self
        let zeroKeypadView = KeypadDigitView(digit: 0)
        zeroKeypadView.delegate = self
        let deleteKeypadView = KeypadStringView(string: "<") // TODO: Add remove icon
        deleteKeypadView.delegate = self
        [dotKeypadView, zeroKeypadView, deleteKeypadView].forEach { row.addArrangedSubview($0) }
        return row
    }
    
    func rowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = ViewConstants.spacing
        stackView.distribution = .fillEqually
        return stackView
    }
}

// MARK: - KeypadDigitViewDelegate

extension KeyboardViewController: KeypadDigitViewDelegate {
    
    public func didTap(digit: Int) {
        delegate?.didTap(digit: digit)
    }
}

// MARK: - KeypadStringViewDelegate

extension KeyboardViewController: KeypadStringViewDelegate {
    
    public func didTap(string: String) {
        if string == "." {
            delegate?.didTapDot()
        } else if string == "<" {
            delegate?.didTapDelete()
        }
    }
}

// MARK: - KeypadImageViewDelegate

extension KeyboardViewController: KeypadImageViewDelegate {
    
    public func didTapImage() {
        
    }
}
