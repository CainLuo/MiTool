//
//  TakumiRecordApiManager.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper
import Combine
import Alamofire

struct TakumiRecordRequestConfiguration: ApiRequestConfiguration {
    var host: String {
        ApiKeys.Host.takumiRecord.rawValue
    }
    
    var path: String
    var accountRegion: AccountRegion = .china
    var method: Alamofire.HTTPMethod
    var parameters: Alamofire.Parameters?
    var headers: Alamofire.HTTPHeaders?
    var encoding: Alamofire.ParameterEncoding = URLEncoding.default
}

public class TakumiRecordApiManager: ApiRequestManager {
    public static let shared = TakumiRecordApiManager()
    
    public var deviceFP: String = ""
    public var deviceID: String = ""
    public var region: AccountRegion = .china
    public var cookie: String = ""
    public var sToken: String = ""
    public var cookieToken: String = ""

    private override init() { }

    public func gameCards<T: Mappable>(
        uid: String
    ) -> AnyPublisher<T, Never> {
        var configuration = TakumiRecordRequestConfiguration(
            path: ApiKeys.Mihoyo.gameRecord.rawValue,
            method: .get,
            parameters: ["uid": uid]
        )
        
        let headers = ApiHeaderModel(
            accept: "",
            acceptEncoding: "",
            acceptLanguage: "",
            connection: "",
            cookie: "cookie", // + "stoken=\(sToken)",
            decodeSalt: ApiDSHelper.getDS1(),
            origin: "",
            referer: "https://webstatic.mihoyo.com",
            secFetchDest: "",
            secFetchMode: "",
            secFetchSite: "",
            userAgent: "",
            xRpcAppVersion: "2.63.1",
            xRpcClientType: "2",
            xRpcDeviceFP: "deviceFP",
            xRpcDeviceID: "deviceID",
            xRpcLanguage: "",
            xRpcPage: ""
        ).toJSON()
        
        guard let headers = headers as? [String: String] else {
            fatalError("headers not [String: String] type")
        }

        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
}

// MARK: - Honkai: StarRail
extension TakumiRecordApiManager {
    public func starRailWidget<T: Mappable>(
        with accountRegion: AccountRegion
    ) -> AnyPublisher<T, Never> {
        var configuration = TakumiRecordRequestConfiguration(
            path: ApiKeys.StarRail.widget.rawValue,
            accountRegion: accountRegion,
            method: .get
        )
        
        let decodeSalt = ApiDSHelper.getDS(
            region: configuration.accountRegion,
            query: ""
        )
        
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: configuration.accountRegion,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": "user.cookie",
                "x-rpc-device_fp": "deviceFP",
                "x-rpc-device_id": "deviceID"
            ]
        )
        
        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
}

// MARK: - Genshin Impact
extension TakumiRecordApiManager {
    public func genshinWidget<T: Mappable>(
        with accountRegion: AccountRegion
    ) -> AnyPublisher<T, Never> {
        var configuration = TakumiRecordRequestConfiguration(
            path: ApiKeys.GenshinImpact.widget.rawValue,
            accountRegion: accountRegion,
            method: .get
        )
        
        let decodeSalt = ApiDSHelper.getDS(
            region: configuration.accountRegion,
            query: ""
        )
        
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: configuration.accountRegion,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": "user.cookie",
                "x-rpc-device_fp": "deviceFP",
                "x-rpc-device_id": "deviceID"
            ]
        )
        
        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
    
    public func genshinRoleList<T: Mappable>(
        with uid: String,
        roleRegion: String
    ) -> AnyPublisher<T, Never> {
        let parameters = [
            "role_id": uid,
            "server": roleRegion
        ]
        var configuration = TakumiRecordRequestConfiguration(
            path: ApiKeys.GenshinImpact.widget.rawValue,
            method: .get,
            parameters: parameters
        )
        
        guard let body = parameters.toJSONString?.removeNewlinesAndSpaces() else {
            fatalError("Invalid body: \(parameters)")
        }
        
        let decodeSalt = ApiDSHelper.getDS(
            region: configuration.accountRegion,
            query: "",
            body: body
        )
        
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: configuration.accountRegion,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": "cookie",
                "x-rpc-device_fp": "deviceFP",
                "x-rpc-device_id": "deviceID",
                "x-rpc-client_type": "5",
                "x-rpc-app_version": "2.60.1",
                "x-requested-with": "com.mihoyo.hyperion",
                "referer": "https://webstatic.mihoyo.com"
            ]
        )
        
        configuration.headers = HTTPHeaders(headers)
        return request(with: configuration)
    }
}
