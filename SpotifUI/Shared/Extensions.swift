//
//  Extensions.swift
//  SwiftUIBoost
//
//  Created by Niccolò Vianello on 28/05/25.
//

import Foundation

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        do {
            let (data, response) = try await data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.init(rawValue: httpResponse.statusCode))
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy
            decoder.dataDecodingStrategy = dataDecodingStrategy
            decoder.dateDecodingStrategy = dateDecodingStrategy
            
            let decoded = try decoder.decode(T.self, from: data)
            
            return decoded
        } catch let error {
            print(error)
            throw error
        }
    }
}
