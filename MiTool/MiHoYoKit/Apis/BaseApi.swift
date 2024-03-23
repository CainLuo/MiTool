//
//  BaseApiManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Combine
import Foundation
import Alamofire
import ObjectMapper

enum BaseRequestableError: Error {
    case invalidData
    case mappingFailed
}

protocol BaseRequestable {
    func get<T: Mappable>(
        url: URLConvertible,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> AnyPublisher<T, Never>
    
    func post<T: Mappable>(
        url: URLConvertible,
        parameters: Parameters?, 
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> AnyPublisher<T, Never>
    
    func request<T: Mappable>(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?
    ) -> AnyPublisher<T, Never>
}

class BaseApiManager: BaseRequestable {
    private let sessionManager: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        
        self.sessionManager = Session(configuration: configuration)
    }
    
    func get<T: Mappable>(
        url: URLConvertible,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) -> AnyPublisher<T, Never> {
        request(
            url: url,
            method: .get,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
    
    func post<T: Mappable>(
        url: URLConvertible,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) -> AnyPublisher<T, Never> {
        request(
            url: url,
            method: .post,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
    
    func request<T: Mappable>(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders?
    ) -> AnyPublisher<T, Never> {
        Future<T, Never> { promise in
            self.sessionManager.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let value):
                    if let jsonData = value,
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        if let object = Mapper<T>().map(JSONString: jsonString) {
                            promise(.success(object))
                        } else {
                            Logger.error(BaseRequestableError.mappingFailed)
                        }
                    } else {
                        Logger.error(BaseRequestableError.invalidData)
                    }
                case .failure(let error):
                    Logger.error(error)
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
