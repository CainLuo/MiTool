//
//  ApiManager+Stoken.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire

extension ApiManager {
    /// Get SToken V2
    /// [UIGF Documents](https://github.com/UIGF-org/mihoyo-api-collect/blob/main/hoyolab/user/token.md#%E9%80%9A%E8%BF%87stokenv1%E8%8E%B7%E5%8F%96stokenv2)
    /// - Parameter completion: completion: @escaping (String) -> Void
    func converSTokenV2(completion: @escaping (String) -> Void) {
        let url = ApiKeys.Host.stokenV2.rawValue + ApiKeys.Mihoyo.stoken.rawValue
        post(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(["x-rpc-app_id": "bll8iq97cem8"])
        ) { (result: Result<MihoyoSTokenModel, Error>) in
            switch result {
            case .success(let success):
                if let token = success.data?.token?.token {
                    completion(token)
                }
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
