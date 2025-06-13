//
//  DatabaseHelper.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError
}

actor APIHelper {
    
    internal struct QueryParams {
        var params: [String: String]
    }
    
    internal class URLBuilder {
        
        var components = URLComponents()
        
        init() {
            components.scheme = Constants.scheme
            components.host = Constants.host
            components.path = Constants.path
        }
        
        func buildURL(with queryParams: QueryParams) -> URL? {
            
            var items = [URLQueryItem]()
            
            for (key, value) in queryParams.params {
                items.append(URLQueryItem(name: key, value: value))
            }
            
            components.queryItems = items
            
            return components.url
        }
        
        func buildURL(appending toAppend: String) -> URL? {
            return components
                .url?.appending(component: toAppend)
        }
    }
    
    func fetchPage(pageIndex: Int = 0, pageLimitCount: Int = 20) async throws -> ReleaseResult? {
        
        let params = buildParams([
            "per_page": "\(pageLimitCount)",
            "page": "\(pageIndex)"
        ])
        
        let finalUrl = URLBuilder().buildURL(with: params)
        
        guard let finalUrl else {
            throw URLError(.badURL)
        }
        
        guard let data = try await makeRequest(finalUrl: finalUrl) else {
            throw APIError.invalidResponse
        }
        
        return try decode(ReleaseResult.self, data)
    }
    
    func fetchRelease(named name: String) async throws -> Release {
        let finalUrl = URLBuilder().buildURL(appending: name)
        
        guard let finalUrl else {
            throw URLError(.badURL)
        }
        
        guard let data = try await makeRequest(finalUrl: finalUrl) else {
            throw APIError.invalidResponse
        }
        
        return try decode(Release.self, data)
    }
    
    func fetchUsers() async throws -> UserArray {
        
        guard let url = URL(string: Constants.usersURL) else {
            throw URLError(.badURL)
        }
        
        guard let data = try await makeRequest(finalUrl: url) else {
            throw APIError.invalidResponse
        }
        
        return try decode(UserArray.self, data, printJSON: true)
    }
    
    private func buildParams(_ params: [String: String]) -> QueryParams {
        QueryParams(params: params)
    }
    
    private func makeRequest(finalUrl: URL) async throws -> Data? {
        let request = URLRequest(url: finalUrl)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode) else {
            return nil
        }
        
        return data
    }
    
    private func decode<T: Decodable>(_ type: T.Type = T.self, _ data: Data, decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase, printJSON: Bool = false) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = decodingStrategy
            
            if printJSON {
                self.printJSON(data)
            }
            
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch let error {
            print("Could not decode JSON of type \(T.self): \(error)")
            throw error
        }
    }
    
    private func printJSON(_ data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            let prettyPrintedData = try JSONSerialization.data(
                withJSONObject: jsonObject,
                options: [.prettyPrinted, .sortedKeys]
            )
            let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)!
            print(prettyPrintedString)
        } catch {
            print("Failed to parse JSON: \(error)")
        }
    }
    
}
