//
//  ApiManager+Genshin.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

extension ApiManager {
    func fetchGenshinWidget<T: Mappable>(
        uid: String
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.GenshinImpact.widget.rawValue
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie + "stoken: \(sToken)",
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID
            ]
        )
        
        return get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<GenshinWidgetModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let data = success.data else {
//                    return
//                }
//                SQLManagerHelper.saveGenshinWidget(uid: uid, model: data)
//                completion(data)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }
}
