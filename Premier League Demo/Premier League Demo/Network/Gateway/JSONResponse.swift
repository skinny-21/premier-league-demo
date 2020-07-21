//
//  JSONResponse.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

struct JSONResponse<Response: Decodable>: APIResponse {
    typealias ResponseType = Response

    func response(for data: Data) throws -> ResponseType {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(ResponseType.self, from: data)
    }
}
