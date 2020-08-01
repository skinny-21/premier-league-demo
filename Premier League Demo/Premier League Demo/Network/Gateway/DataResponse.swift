//
//  DataResponse.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct DataResponse: APIResponse {
    typealias ResponseType = Data

    func response(for data: Data) throws -> Data {
        data
    }
}
