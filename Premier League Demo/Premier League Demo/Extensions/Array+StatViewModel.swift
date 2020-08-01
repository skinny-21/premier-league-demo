//
//  Array+StatViewModel.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

extension Array where Element == StatViewModel {
    mutating func appendRankItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleSmall, valueStyle: .statValueBig)
    }

    mutating func appendSummaryItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleSmall, valueStyle: .statValueSmall)
    }

    mutating func appendFormItem(title: String, value: Int?) {
        appendStatItem(title: title, value: value, titleStyle: .statTitleBig, valueStyle: .statValueBig)
    }

    mutating func appendStatItem(title: String, value: Int?, titleStyle: TextStyle, valueStyle: TextStyle) {
        if let value = value {
            self.append(StatViewModel(title: title, value: "\(value)", titleStyle: titleStyle, valueStyle: valueStyle))
        }
    }
}
