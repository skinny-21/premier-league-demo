//
//  Request.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class Request<Response: APIResponse>: APIRequest {
    let response: Response
    let session: URLSession
    let urlCache: URLCache?
    var urlRequest: URLRequest

    init(session: URLSession, urlRequest: URLRequest, response: Response, urlCache: URLCache?) {
        self.session = session
        self.urlRequest = urlRequest
        self.response = response
        self.urlCache = urlCache
    }

    @discardableResult
    func makeRequest(with completionHandler: @escaping ResponseHandler<Response.ResponseType>) -> URLSessionDataTask? {
        if let cachedData = urlCache?.cachedResponse(for: urlRequest)?.data, let cachedResult = result(for: cachedData) {
            completionHandler(cachedResult, nil)
            return nil
        }

        let task = dataTask(with: completionHandler)
        task.resume()
        return task
    }

    private func dataTask(with completionHandler: @escaping ResponseHandler<Response.ResponseType>) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completionHandler(nil, error)
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                return completionHandler(nil, error)
            }

            guard let data = data, data.count > 0 else {
                return completionHandler(nil, error)
            }

            do {
                let result: APIResponseType.ResponseType = try self.response.response(for: data)
                self.cache(response: response, data: data, for: self.urlRequest)
                return completionHandler(result, nil)
            } catch {
                return completionHandler(nil, error)
            }
        }

        return dataTask
    }

    private func result(for cachedData: Data) -> APIResponseType.ResponseType? {
        let result: APIResponseType.ResponseType? = try? response.response(for: cachedData)
        return result
    }

    private func cache(response: URLResponse?, data: Data?, for urlRequest: URLRequest) {
        if let urlCache = urlCache, let response = response, let data = data {
            urlCache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
        }
    }
}
