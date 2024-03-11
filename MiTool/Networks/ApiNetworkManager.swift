//
//  ApiNetworkManager.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

enum ApiNetworkError: Error {
    case invalidData
    case requestFailed(Error)
}

protocol ApiNetworkService {
    func createServerError() -> NSError
    func performRequest<T: Mappable>(
        url: URL,
        parameters: [String: String]?
    ) async throws -> T
}

class ApiNetworkManager: ApiNetworkService {
    func createServerError() -> NSError {
        return NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
    }
    
    func performRequest<T: Mappable>(
        url: URL,
        parameters: [String: String]? = nil
    ) async throws -> T {
        let finalURL = try buildURL(with: url, parameters: parameters)
        let (data, response) = try await URLSession.shared.data(from: finalURL)
        
        try validateResponse(response)
        
        let json = try parseJSON(data)
        
        guard let object = Mapper<T>().map(JSON: json) else {
            throw ApiNetworkError.invalidData
        }
        
        return object
    }
    
    private func buildURL(with url: URL, parameters: [String: String]?) throws -> URL {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw ApiNetworkError.invalidData
        }
        
        if let params = parameters {
            urlComponents.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let finalURL = urlComponents.url else {
            throw ApiNetworkError.invalidData
        }
        
        return finalURL
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiNetworkError.requestFailed(createServerError())
        }
    }
    
    private func parseJSON(_ data: Data) throws -> [String: Any] {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw ApiNetworkError.invalidData
        }
        return json
    }
}
