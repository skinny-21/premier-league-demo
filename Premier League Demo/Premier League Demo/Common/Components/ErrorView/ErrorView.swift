//
//  ErrorView.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    var isRetryButtonHidden = false {
        didSet {
            retryButton.isHidden = isRetryButtonHidden
        }
    }
    weak var delegate: ErrorViewDelegate?
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let retryButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        [titleLabel, retryButton].forEach(stackView.addArrangedSubview)
        
        titleLabel.text = "Data could not be retrieved"
        titleLabel.setTextStyle(.textLeading)
        
        retryButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        retryButton.setTitle("Try again", for: .normal)
        retryButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        retryButton.setTextStyle(.button)
        retryButton.backgroundColor = .buttonBackground
        retryButton.addTarget(self, action: #selector(retryButtonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            retryButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc
    private func retryButtonAction() {
        delegate?.errorViewRequestedRetryAction(self)
    }
}
