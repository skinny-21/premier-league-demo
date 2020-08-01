//
//  UIImage+OptionalData.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import UIKit

extension UIImage {
    static func fromData(data: Data?) -> UIImage? {
        if let imageData = data {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
}
