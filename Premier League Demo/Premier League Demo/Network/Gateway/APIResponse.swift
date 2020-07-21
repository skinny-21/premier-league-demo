//
//  APIResponse.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

typealias ResponseHandler<DataType> = (_ response: DataType?, _ error: Error?) -> Void

protocol APIResponse {
    associatedtype ResponseType
    func response(for data: Data) throws -> ResponseType
}
