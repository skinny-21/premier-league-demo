//
//  Logger.swift
//  Premier League Demo
//
//  Created by Wojciech Wozniak on 21/07/2020.
//  Copyright © 2020 Wojciech Wozniak. All rights reserved.
//

import Foundation

let log = Logger()

class Logger {
    private let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }

    private func prettyData(from data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: [])
            return prettyData
        } catch {
            return data
        }
    }

    private func printLog(_ prefix: String, _ message: String) {
        let timestamp = dateFormatter.string(from: Date())
        print("\(timestamp) \(prefix) \(message)")
    }

    func request(_ request: URLRequest) {
        printLog("🟦 Request", "\(request.httpMethod ?? "") \(request.description)")
    }

    func response(_ response: URLResponse?, for request: URLRequest, with data: Data?) {
        let requestInfo = "\(request.httpMethod ?? "") \(request.description)"

        guard let httpResponse = response as? HTTPURLResponse else {
            let prefix = "🟥"
            printLog(prefix, "Empty response: \(requestInfo)")
            return
        }

        let headersArray = httpResponse.allHeaderFields.map { "\"\($0.key)\": \"\($0.value)\"" }

        let icon: String
        switch httpResponse.statusCode {
        case 304:
            icon = "🟧"
        case 200...299:
            icon = "🟩"
        default:
            icon = "🟨"
        }

        let prefix = icon + " Response"
        printLog(prefix, "\(requestInfo)")
        printLog(prefix, "status code: \(httpResponse.statusCode.description)")
        printLog(prefix, "headers: [\(headersArray.joined(separator: ", "))]")

        if let data = data, let stringData = String(data: prettyData(from: data), encoding: .utf8) {
            printLog(prefix, "body: \(stringData.trimmed())")
        }
    }

    func error(_ error: Error?) {
        if let error = error {
            printLog("🟥", "Response error: \(String(describing: error))")
        }
    }

    func cached(_ urlRequest: URLRequest, _ bodyString: String) {
        let prefix = "🟪 Cached response"
        printLog(prefix, "\(urlRequest.httpMethod ?? "") \(urlRequest.description)")
        printLog(prefix, "body: \(bodyString.trimmed())")
    }
}

private extension String {
    func trimmed() -> String {
        let maxLength = 2048
        let suffix = count > maxLength ? " (...)" : ""
        return prefix(maxLength).appending(suffix)
    }
}
