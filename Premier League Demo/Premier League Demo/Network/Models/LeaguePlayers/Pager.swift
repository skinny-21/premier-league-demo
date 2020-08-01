//
//  Pager.swift
//  Premier League Demo
//
//  Created by Wojciech Woźniak on 01/08/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct Pager: Decodable {
    let currentPage: Int
    let maxPage: Int
    let resultsPerPage: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case maxPage = "max_page"
        case resultsPerPage = "results_per_page"
        case totalResults = "total_results"
    }
}
