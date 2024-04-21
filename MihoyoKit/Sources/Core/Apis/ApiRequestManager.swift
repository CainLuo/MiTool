//
//  ApiRequestManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Combine
import Foundation
import Alamofire
import ObjectMapper

public protocol ApiRequestConfiguration {
    var host: String { get }
    var path: String { get set }
    var accountRegion: AccountRegion { get set }
    var method: HTTPMethod { get set }
    var parameters: Parameters? { get set }
    var headers: HTTPHeaders? { get set }
    var encoding: ParameterEncoding { get set }
}

enum ApiRequestableError: Error {
    case invalidData
    case mappingFailed
}

public protocol ApiRequestProtocol {
    func request<T: Mappable>(with configuration: ApiRequestConfiguration) -> AnyPublisher<T, Never>
}

public class ApiRequestManager: ApiRequestProtocol {
    public func request<T>(with configuration: ApiRequestConfiguration) -> AnyPublisher<T, Never> where T: Mappable {
        Future<T, Never> { promise in
            AF.request(
                configuration.host + configuration.path,
                method: configuration.method,
                parameters: configuration.parameters,
                encoding: configuration.encoding,
                headers: configuration.headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let value):
                    if let jsonData = value,
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        if let object = Mapper<T>().map(JSONString: jsonString) {
                            promise(.success(object))
                        } else {
                            Logger.error(ApiRequestableError.mappingFailed)
                        }
                    } else {
                        Logger.error(ApiRequestableError.invalidData)
                    }
                case .failure(let error):
                    Logger.error(error)
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
