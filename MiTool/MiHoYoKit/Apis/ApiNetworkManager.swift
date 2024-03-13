//
//  ApiNetworkManager.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import Alamofire
import ObjectMapper

enum ApiNetworkError: Error {
    case invalidData
    case requestFailed(Error)
}

protocol ApiNetworkService {
    func createServerError() -> NSError
    func performRequest<T: Mappable>(
        url: URL,
        headers: [String: String]?,
        parameters: [String: String]?
    ) async throws -> T
}

class ApiNetworkManager: ApiNetworkService {
    func createServerError() -> NSError {
        return NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
    }
    
    func performRequest<T: Mappable>(
        url: URL,
        headers: [String: String]? = nil,
        parameters: [String: String]? = nil
    ) async throws -> T {
        let finalURL = try buildURL(with: url, parameters: parameters)
        var request = URLRequest(url: finalURL)
        
        // 设置请求头信息
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
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
        
        urlComponents.scheme
        
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

protocol NetworkRequest {
    associatedtype ResponseType: Mappable

    func fetchData(from path: String, method: HTTPMethod, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<ResponseType, Error>) -> Void)

    func get(from path: String, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<ResponseType, Error>) -> Void)

    func post(from path: String, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<ResponseType, Error>) -> Void)
}

extension NetworkRequest {

    func get(from path: String, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        fetchData(from: path, method: .get, host: host, scheme: scheme, headers: headers, parameters: parameters, completion: completion)
    }

    func post(from path: String, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<ResponseType, Error>) -> Void) {
        fetchData(from: path, method: .post, host: host, scheme: scheme, headers: headers, parameters: parameters, completion: completion)
    }
}

class NetworkManager<T: Mappable>: NetworkRequest {
    func fetchData(from path: String, method: HTTPMethod, host: String, scheme: String, headers: HTTPHeaders?, parameters: Parameters?, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = URL(string: "\(scheme)://\(host)\(path)") {
            Logger.info(url.absoluteString)
            AF.request(url, method: method, parameters: parameters, headers: headers).response { response in
                switch response.result {
                case .success(let data):
                    if let jsonData = data, let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                        if let object = Mapper<T>().map(JSONObject: json) {
                            completion(.success(object))
                        } else {
                            Logger.error(NSError(domain: "Mapping Error", code: 0, userInfo: nil))
                            completion(.failure(NSError(domain: "Mapping Error", code: 0, userInfo: nil)))
                        }
                    } else {
                        Logger.error(NSError(domain: "JSON Serialization Error", code: 0, userInfo: nil))
                        completion(.failure(NSError(domain: "JSON Serialization Error", code: 0, userInfo: nil)))
                    }
                case .failure(let error):
                    Logger.error(error)
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(NSError(domain: "URL Error", code: 0, userInfo: nil)))
        }
    }
}
