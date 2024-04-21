//
//  ApiHeaderConfiguration.swift
//  MiTool
//
//  Created by Cain on 2024/3/11.
//

import Foundation
import ObjectMapper

enum ApiHeaderConfiguration {
    static let userAgent: String = """
    Mozilla/5.0 (iPhone; CPU iPhone OS 16_3_1 like Mac OS X) \
    AppleWebKit/605.1.15 (KHTML, like Gecko) miHoYoBBS/2.51.1
    """
    
    static func recordURLAPIHost(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "api-takumi-record.mihoyo.com"
        case .global:
            return "bbs-api-os.hoyolab.com"
        }
    }
    
    static func accountAPIURLHost(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "api-takumi.mihoyo.com"
        case .global:
            return "api-account-os.hoyolab.com"
        }
    }
    
    static func hk4eAPIURLHost(region: AccountRegion) -> String {
        switch region {
        case .china:
            "hk4e-api.mihoyo.com"
        case .global:
            "sg-hk4e-api.hoyolab.com"
        }
    }
    
    static func hostInHeaders(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "https://api-takumi-record.mihoyo.com/"
        case .global:
            return "https://bbs-api-os.mihoyo.com/"
        }
    }
    
    static func salt(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs"
        case .global:
            return "okr4obncj8bw5a65hbnn5oo6ixjc3l9w"
        }
    }
    
    static func xRpcAppVersion(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "2.60.1"
        case .global:
            return "2.33.0"
        }
    }
    
    static func xRpcClientType(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "5"
        case .global:
            return "2"
        }
    }
    
    static func referer(region: AccountRegion) -> String {
        switch region {
        case .china:
            return "https://webstatic.mihoyo.com"
        case .global:
            return "https://webstatic-sea.hoyolab.com"
        }
    }
    
    /// Get unfinished default headers containing host, api-version, etc.
    /// You need to add `DS` field using `URLRequestHelper.getDS` manually
    /// - Parameter region: the region of the account
    /// - Returns: http request headers
    static func defaultHeaders(region: AccountRegion, additionalHeaders: [String: String]?) -> [String: String] {
        let mihoyoLang = Locale.miHoYoAPILanguage.rawValue
        let language = "\(LanguageManager.getUpLang()),\(mihoyoLang);q=0.9"

        var headers = ApiHeaderModel(
            accept: "application/json, text/plain, */*", 
            acceptEncoding: "gzip, deflate, br", 
            acceptLanguage: language, 
            connection: "keep-alive", 
            origin: referer(region: region), 
            referer: referer(region: region),
            secFetchDest: "empty",
            secFetchMode: "cors",
            secFetchSite: "same-site", 
            userAgent: userAgent,
            xRpcAppVersion: xRpcAppVersion(region: region),
            xRpcClientType: xRpcClientType(region: region),
            xRpcLanguage: mihoyoLang, xRpcPage: "v4.1.5-ys_#/ys/daily"
        ).toJSON()
        
        if let additionalHeaders {
            headers.merge(additionalHeaders) { $1 }
        }
        
        guard let headers = headers as? [String: String] else {
            fatalError("headers is not [String: String] type")
        }
        
        return headers
    }
    
    static func baseHeaders(region: AccountRegion, additionalHeaders: [String: String]?) -> [String: String] {
        var headers = ApiHeaderModel(
            accept: "application/json, text/plain, */*", 
            acceptEncoding: "gzip, deflate, br",
            acceptLanguage: "zh-CN,zh-Hans;q=0.9",
            connection: "keep-alive", 
            origin: referer(region: region), 
            referer: referer(region: region) 
        )
            .toJSON()
        if let additionalHeaders {
            headers.merge(additionalHeaders) { $1 }
        }
        
        guard let headers = headers as? [String: String] else {
            fatalError("headers not [String: String] type")
        }
        
        return headers
    }
}

// API请求的类型枚举
enum ApiRequestType {
    case roleData
    case weaponList
    case weaponCompute
    // 添加其他的类型
}

struct User {
    let cookie: String
    let region: String
    let cookieToken: String

    // 添加其他的用户信息
}

class HeadersFactory {
    private let user: User

    init(user: User) {
        self.user = user
    }

    func headers(for requestType: ApiRequestType) -> [String: String] {
        var headers: [String: String] = ["Cookie": user.cookie]

        switch requestType {
        case .roleData:
            break
        case .weaponList:
            headers["Region"] = user.region
        case .weaponCompute:
            headers["CookieToken"] = user.cookieToken
        // 添加其他的case，根据具体的请求类型返回不同的请求头
        }

        return headers
    }
}

public class AAAApiRequestManager {
    static let shared = AAAApiRequestManager()

    var currentUser: User? {
        didSet {
            headersFactory = HeadersFactory(user: currentUser!)
        }
    }

    private var headersFactory: HeadersFactory?

    func request(api: String, requestType: ApiRequestType, completion: (Data?, URLResponse?, Error?) -> Void) {
        guard let headers = headersFactory?.headers(for: requestType) else {
            return
        }

        // 这里你会创建一个URLRequest，并将headers设置为请求的头部，
        // 然后使用URLSession或者其他网络请求库来发送此请求。

        // 比如：
        /*
        var request = URLRequest(url: URL(string: api)!)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
        */
    }
}
