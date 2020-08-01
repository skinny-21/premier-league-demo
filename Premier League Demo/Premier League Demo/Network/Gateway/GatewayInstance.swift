//
//  GatewayInstance.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

class GatewayInstance {
    private let baseURL = URL(string: "https://api.footystats.org")
    private let apiKey = "test85g57"
    private let session = URLSession(configuration: .ephemeral)
    private let urlCache = URLCache()

    @discardableResult
    private func makeJSONRequest<ResponseType: APIResponse>(urlRequest: URLRequest?,
                                                            apiResponse: ResponseType,
                                                            completionHandler: @escaping ResponseHandler<ResponseType.ResponseType>,
                                                            urlCache: URLCache? = nil) -> URLSessionDataTask? {
        guard let urlRequest = urlRequest else {
            return nil
        }

        let request = Request(session: session, urlRequest: urlRequest, response: apiResponse, urlCache: urlCache)
        let dataTask = request.makeRequest(with: completionHandler)
        return dataTask
    }


    private func createURLRequest(endpoint: GatewayEndpoint) -> URLRequest? {
        guard var url = baseURL?.appendingPathComponent(endpoint.path) else {
            return nil
        }

        url.appendQueryItem(URLQueryItem(name: "key", value: apiKey))
        url.appendQueryItem(URLQueryItem(name: "season_id", value: "2012"))
        
        endpoint.query?.forEach {
            url.appendQueryItem($0)
        }
        
        return URLRequest(url: url)
    }
}

// MARK: - Gateway
extension GatewayInstance: Gateway {
    func getLeagueTable(completionHandler: @escaping ResponseHandler<LeagueTableResponse>) {
        let urlRequest = createURLRequest(endpoint: .leagueTable)
        makeJSONRequest(urlRequest: urlRequest, apiResponse: JSONResponse(), completionHandler: completionHandler)
    }

    func getImage(url: URL, completionHandler: @escaping ResponseHandler<Data>) {
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        makeJSONRequest(urlRequest: urlRequest, apiResponse: DataResponse(), completionHandler: completionHandler, urlCache: urlCache)
    }
    
    func getTeamDetails(completionHandler: @escaping ResponseHandler<TeamDetailsListResponse>) {
        
    }
}
