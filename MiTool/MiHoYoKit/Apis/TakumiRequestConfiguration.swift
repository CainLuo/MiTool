//
//  TakumiRequestConfiguration.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import Alamofire

class TakumiRequestConfiguration: ApiRequestConfiguration {
    var host: String {
        ApiKeys.Host.takumi.rawValue
    }
    var path: String
    var method: Alamofire.HTTPMethod
    var parameters: Alamofire.Parameters?
    var headers: Alamofire.HTTPHeaders?
    var encoding: Alamofire.ParameterEncoding
    
    init(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = JSONEncoding.default
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding
    }
}
