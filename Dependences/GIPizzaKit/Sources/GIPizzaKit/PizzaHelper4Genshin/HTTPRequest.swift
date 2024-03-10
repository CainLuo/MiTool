//
//  HTTPMethod.swift
//
//
//  Created by Bill Haku on 2023/3/27.
//  HTTP请求方法

import Foundation
import HBMihoyoAPI

// MARK: - Method

enum Method {
    case post
    case get
    case put
}

// MARK: - HttpMethod

@available(iOS 13, watchOS 6, *)
extension HttpMethod {
    /// 返回自己的后台的结果接口
    /// - Parameters:
    ///   - method:Method, http方法的类型
    ///   - url:String，请求的路径
    ///   - completion:异步返回处理好的data以及报错的类型
    ///
    ///  需要自己传URL类型的url过来
    public static func homeRequest(
        _ method: Method,
        _ urlStr: String,
        cachedPolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        hostType: HostType = .generalHost,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        completion: @escaping (
            (Result<T, RequestError>) -> ()
        )
    ) {
        homeRequest(
            method,
            urlStr,
            cachedPolicy: cachedPolicy,
            baseStr: hostType.hostBase,
            keyDecodingStrategy: .useDefaultKeys
        ) { neta in
            completion(neta)
        }
    }
}
