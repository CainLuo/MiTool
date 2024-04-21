//
//  GenshinApiManager.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper
import Combine
import Alamofire

struct GenshinRequestConfiguration: ApiRequestConfiguration {
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

public class GenshinApiManager: ApiRequestManager {
    public static let shared = GenshinApiManager()
    
    public var cookie: String = ""
    public var cookieToken: String = ""
    public var accountRegion: AccountRegion = .china

    private override init() { }
    
    func fetchGenshinRoleSkills<T: Mappable>(
        with parameters: GenshinRoleSkillsRequestModel
    ) -> AnyPublisher<T, Never> {
        
        var accountID = ""
        let strings = cookie.components(separatedBy: ";")
        let stuids = strings.filter { $0.contains("stuid=") }
        if let uidString = stuids.first {
            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
            accountID = "account_id=\(uid)"
        }

        let headers = ApiHeaderModel(
            cookie: "\(accountID);cookie_token=\(cookieToken)",
            referer: "https://webstatic.mihoyo.com"
        )
            .toJSON()
        
        guard let headers = headers as? [String: String] else {
            fatalError("headers is not [String: String] type")
        }

        let configuration = GenshinRequestConfiguration(
            path: ApiKeys.GenshinImpact.roleDetail.rawValue,
            method: .get,
            parameters: parameters.toJSON(),
            headers: HTTPHeaders(headers)
        )
        return request(with: configuration)
    }
    
    func fetchGensinWeaponList<T: Mappable>(page: Int) -> AnyPublisher<T, Never> {
        let parameters = GenshinWeaponListRequestModel(page: page)
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: accountRegion,
            additionalHeaders: ["Cookie": "cookie"]
        )
        let configuration = GenshinRequestConfiguration(
            path: ApiKeys.GenshinImpact.weapons.rawValue,
            method: .post,
            parameters: parameters.toJSON(),
            headers: HTTPHeaders(headers)
        )

        return request(with: configuration)
    }
    
    func fetchGensinWeaponCompute<T: Mappable>(
        with parameters: GenshinComputeRequestModel
    ) -> AnyPublisher<T, Never> {
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: accountRegion,
            additionalHeaders: ["Cookie": "cookie"]
        )

        let configuration = GenshinRequestConfiguration(
            path: ApiKeys.GenshinImpact.compute.rawValue,
            method: .post,
            parameters: parameters.toJSON(),
            headers: HTTPHeaders(headers)
        )

        return request(with: configuration)
    }
}
