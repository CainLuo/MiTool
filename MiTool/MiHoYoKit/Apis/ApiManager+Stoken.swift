//
//  ApiManager+Stoken.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

extension ApiManager {
    /// Get SToken V2
    /// [UIGF Documents](https://github.com/UIGF-org/mihoyo-api-collect/blob/main/hoyolab/user/token.md#%E9%80%9A%E8%BF%87stokenv1%E8%8E%B7%E5%8F%96stokenv2)
    /// - Parameter completion: completion: @escaping (String) -> Void
    func fetchSTokenV2<T: Mappable>(cookie: String) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.stokenV2.rawValue + ApiKeys.Mihoyo.stoken.rawValue
        let headers = HTTPHeaders(
            [
                "x-rpc-app_id": "bll8iq97cem8",
                "Cookie": cookie
            ]
        )
        return post(
            url: url,
            parameters: nil,
            headers: headers
        )
    }
}
