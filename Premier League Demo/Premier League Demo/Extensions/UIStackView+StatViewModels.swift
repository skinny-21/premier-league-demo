//
//  UIStackView+StatViewModels.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

extension UIStackView {
    func addStatItems(_ items: [StatViewModel]) {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        items.forEach {
            let statView = StatView()
            statView.setViewModel($0)
            addArrangedSubview(statView)
        }
    }
}
