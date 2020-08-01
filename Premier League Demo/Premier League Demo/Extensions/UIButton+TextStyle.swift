//
//  UIButton+TextStyle.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

extension UIButton {
    func setTextStyle(_ style: TextStyle) {
        setTitleColor(style.config.color, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: style.config.size, weight: style.config.weight)
    }
}
