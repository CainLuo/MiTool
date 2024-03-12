//
//  ApiNetworkManager.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import Alamofire

class ApiNetworkManager: BaseRequestable {
    static let shared = ApiNetworkManager()
    
    private init() { }
}

// swiftlint: disable line_length
extension ApiNetworkManager {
    func fetchStarRailDailyNode(
        roleID: String,
        server: StarRailServerType = .gdCN,
        completion: @escaping (StarRailWidgetModel) -> Void
    ) {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
        let parameters: Parameters = [
            "server": server.rawValue,
            "role_id": roleID
        ]
        let decodeSalt = ApiDSHelper.getDS(
            region: .china,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: .china, 
            additionalHeaders: ["DS": decodeSalt,
                                "Cookie": "stuid=182692936; stoken=4zsu4C9d0UUFg3f82eYlgm8uJwFbjsAcARQnRb3T; ltuid=182692936; ltoken=ZTwWusQfepBrz3m9NtJiAplUmaChRb9n4NanTohR; stoken: v2_NPZba7CNhNAHPChwBYSTLs1Fgn-pGNdyn2oaGaNK8LIxo7CNnuFYCGbpm8fLZGk9KGQxW859xElWsthP80LY9IV0Zr8v.CAE=",
                                "x-rpc-device_fp": "38d7ebd3b45ae",
                                "x-rpc-device_id": "30BB3DC8-FDB8-4574-800F-926E7F7F6B39"]
        )
        
        get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailWidgetModel, Error>) in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                Logger.error(message: failure)
            }
        }
    }
}
