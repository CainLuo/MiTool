//
//  ApiManager+Genshin.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire

extension ApiManager {
    func fetchGenshinWidget(
        uid: String,
        parameters: Parameters,
        server: Region = .china,
        stoken: String,
        completion: @escaping (Result<StarRailWidgetModel, Error>) -> Void
    ) {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.GenshinImpact.widget.rawValue
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: ["DS": decodeSalt,
                                "Cookie": cookie + "stoken: \(stoken)",
                                "x-rpc-device_fp": deviceFP,
                                "x-rpc-device_id": deviceID]
        )
        
        get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailWidgetModel, Error>) in
            switch result {
            case .success(let success):
                guard let data = success.data else {
                    return
                }
                SQLManagerHelper.saveStarRailWidget(uid: uid, model: data)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
