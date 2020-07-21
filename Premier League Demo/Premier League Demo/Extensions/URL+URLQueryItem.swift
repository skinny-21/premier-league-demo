//
//  URL+URLQueryItem.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

extension URL {
    mutating func appendQueryItem(_ queryItem: URLQueryItem) {
        guard var pathComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return
        }

        if pathComponents.queryItems == nil {
            pathComponents.queryItems = [queryItem]
        } else {
            pathComponents.queryItems?.append(queryItem)
        }

        if let url = pathComponents.url {
            self = url
        }
    }
}
