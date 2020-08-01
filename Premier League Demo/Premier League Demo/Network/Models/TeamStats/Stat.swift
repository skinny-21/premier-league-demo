//
//  Stat.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct Stat: Decodable {
    let value: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let doubleValue = try? container.decode(Double.self) {
            self.value = "\(doubleValue)"
            return
        }
        
        if let stringValue = try? container.decode(String.self) {
            self.value = stringValue
            return
        }
        
        self.value = nil
    }
}
