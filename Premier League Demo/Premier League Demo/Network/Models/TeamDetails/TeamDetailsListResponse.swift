//
//  TeamDetailsListResponse.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 31/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct TeamDetailsListResponse: Decodable {
    let data: [TeamDetailsResponse]
}
