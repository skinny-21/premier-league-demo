//
//  TextStyle.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

enum TextStyle {
    case text
    case textLeading
    case button
    case statTitleSmall
    case statTitleBig
    case statValueSmall
    case statValueBig
    case header

    var config: TextStyleConfig {
        switch self {
        case .text:
            return TextStyleConfig(color: .primary, size: 11, weight: .light)
        case .textLeading:
            return TextStyleConfig(color: .primary, size: 11, weight: .medium)
        case .button:
            return TextStyleConfig(color: .buttonTitle, size: 12, weight: .medium)
        case .statTitleSmall:
            return TextStyleConfig(color: .primary, size: 12, weight: .light)
        case .statTitleBig:
            return TextStyleConfig(color: .primary, size: 14, weight: .light)
        case .statValueSmall:
            return TextStyleConfig(color: .primary, size: 12, weight: .bold)
        case .statValueBig:
            return TextStyleConfig(color: .primary, size: 20, weight: .bold)
        case .header:
            return TextStyleConfig(color: .primary, size: 26, weight: .bold)

        }
    }
}
