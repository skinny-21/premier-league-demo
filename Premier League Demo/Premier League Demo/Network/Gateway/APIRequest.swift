//
//  APIRequest.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype APIResponseType: APIResponse

    var response: APIResponseType { get }
    var session: URLSession { get }
    var urlRequest: URLRequest { get }
    var urlCache: URLCache? { get }

    func makeRequest(with completionHandler: @escaping ResponseHandler<APIResponseType.ResponseType>) -> URLSessionDataTask?
}
