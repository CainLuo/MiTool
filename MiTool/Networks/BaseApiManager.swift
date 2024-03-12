//
//  BaseApiManager.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/12.
//

import Foundation
import Alamofire
import ObjectMapper

enum BaseRequestableError: Error {
    case invalidData
    case mappingFailed
}

protocol BaseRequestable {
    func request<T: Mappable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
    func get<T: Mappable>(
        url: String,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
    func post<T: Mappable>(
        url: String,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

extension BaseRequestable {
    func get<T: Mappable>(
        url: String,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(
            url: url,
            method: .get,
            parameters: parameters,
            headers: headers,
            completion: completion
        )
    }
    
    func post<T: Mappable>(
        url: String,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(
            url: url,
            method: .post,
            parameters: parameters,
            headers: headers,
            completion: completion
        )
    }
    
    func request<T: Mappable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
//        let fullUrl = "https://" + url // Assuming "https://" as the default scheme
        AF.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers
        )
        .response { response in
            switch response.result {
            case .success(let data):
                if let jsonData = data,
                    let jsonString = String(data: jsonData, encoding: .utf8) {
                    if let object = Mapper<T>().map(JSONString: jsonString) {
                        completion(.success(object))
                    } else {
                        completion(.failure(BaseRequestableError.mappingFailed))
                    }
                } else {
                    completion(.failure(BaseRequestableError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
