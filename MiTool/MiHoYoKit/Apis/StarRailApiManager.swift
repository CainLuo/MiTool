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
    var accountRegion: Region = .china
    var method: Alamofire.HTTPMethod
    var parameters: Alamofire.Parameters?
    var headers: Alamofire.HTTPHeaders?
    var encoding: Alamofire.ParameterEncoding = URLEncoding.default
}

class StarRailApiManager: ApiRequestManager {
    static let shared = StarRailApiManager()
    
    private override init() { }
    
    func featchStarRailRoleList<T: Mappable>(
        with uid: String,
        roleRegion: String,
        page: Int
    ) -> AnyPublisher<T, Never> {
        guard let user = MihoyoUserManager.shared.getUserInfo(uid: uid, isAccountUID: false) else {
            fatalError("Not find role user: \(uid)")
        }
        let configuration = StarRailRequestConfiguration(
            path: ApiKeys.StarRail.avatarList.rawValue,
            accountRegion: user.region,
            method: .get
        )
        let parameters: Parameters = StarRailRoleRequestModel(uid: uid, region: roleRegion, page: page).toJSON()
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: configuration.accountRegion,
            additionalHeaders: ["Cookie": user.cookie]
        )
        
        return request(with: configuration)
    }
}
