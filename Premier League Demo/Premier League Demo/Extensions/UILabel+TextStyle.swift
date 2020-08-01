//
//  UILabel+TextStyle.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

extension UILabel {
    func setTextStyle(_ style: TextStyle) {
        textColor = style.config.color
        font = UIFont.systemFont(ofSize: style.config.size, weight: style.config.weight)
    }
}
