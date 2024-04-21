//
//  StarRailApiManager.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper
import Combine
import Alamofire

struct StarRailRequestConfiguration: ApiRequestConfiguration {
    var host: String {
        ApiKeys.Host.takumi.rawValue
    }
    
    var path: String
    var accountRegion: AccountRegion = .china
    var method: Alamofire.HTTPMethod
    var parameters: Alamofire.Parameters?
    var headers: Alamofire.HTTPHeaders?
    var encoding: Alamofire.ParameterEncoding = URLEncoding.default
}

public class StarRailApiManager: ApiRequestManager {
    public static let shared = StarRailApiManager()
    
    private override init() { }
    
    public func roleList<T: Mappable>(
        parameter: StarRailRoleRequestModel
    ) -> AnyPublisher<T, Never> {
        var configuration = StarRailRequestConfiguration(
            path: ApiKeys.StarRail.avatarList.rawValue,
            accountRegion: .china,
            method: .get,
            parameters: parameter.toJSON()
        )
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: configuration.accountRegion,
            additionalHeaders: ["Cookie": "user.cookie"]
        )
        
        configuration.headers = HTTPHeaders(headers)
        
        return request(with: configuration)
    }
    
    public func roleDetail<T: Mappable>(
        parameter: StarRailRoleDetailRequestModel
    ) -> AnyPublisher<T, Never> {
        var configuration = StarRailRequestConfiguration(
            path: ApiKeys.StarRail.avatarDetail.rawValue,
            accountRegion: .china,
            method: .get,
            parameters: parameter.toJSON()
        )
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: configuration.accountRegion,
            additionalHeaders: ["Cookie": "user.cookie"]
        )
        
        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
    
    public func roleSkillCompute<T: Mappable>(
        parameter: StarRailComputeRequestModel
    ) -> AnyPublisher<T, Never> {
        var configuration = StarRailRequestConfiguration(
            path: ApiKeys.StarRail.compute.rawValue + "?game=hkrpg",
            accountRegion: .china,
            method: .post,
            parameters: parameter.toJSON()
        )
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: configuration.accountRegion,
            additionalHeaders: ["Cookie": "user.cookie"]
        )
        
        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
}
