//
//  UIButton+CommonButton.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

extension UIButton {
    static func commonButton() -> UIButton {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setTextStyle(.button)
        button.backgroundColor = .buttonBackground
        return button
    }
}
