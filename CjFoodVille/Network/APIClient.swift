//
//  APIClient.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/29/25.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func request<T: Decodable> (
        path: String,
        method: String = "GET",
        body: Data? = nil,
        headers: [String: String] = [:],
        responseType: T.Type
    ) async throws -> T {
        let url = URL(string: APIContants.TestBaseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
    
            if let responseString = String(data: data, encoding: .utf8) {
                Log.print(
                    "[APIClient Response] \(responseString)",
                    level: .info,
                    statusCode: statusCode,
                    url: url
                )
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                Log.print(
                    "[APIClient Error] Bad status code",
                    level: .error,
                    statusCode: statusCode,
                    url: url
                )
                throw URLError(.badServerResponse)
            }
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch {
            Log.print(
                "[APIClient Error] \(error.localizedDescription)",
                level: .error,
                url: url
            )
            throw error
        }
    }
}
