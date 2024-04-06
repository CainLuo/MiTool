//
//  ApiManager+StarRail.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

extension ApiManager {
    func fetchStarRailWidget<T: Mappable>(
        with uid: String,
        server: Region = .china
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie,
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID
            ]
        )
        
        return get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        )
    }

    func fetchStarRailRoleSkillCompute<T: Mappable>(
        with request: StarRailRoleComputeRequestModel
    ) -> AnyPublisher<T, Never> {
        let parameters: Parameters = request.toJSON()
                
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.StarRail.compute.rawValue + "?game=hkrpg"

        let headers = ApiHeaderConfiguration.baseHeaders(
            region: region,
            additionalHeaders: [
                "Cookie": cookie
            ]
        )
        
        return post(
            url: url,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchStarRailRoleDetail<T: Mappable>(
        with uid: String,
        roleID: String
    ) -> AnyPublisher<T, Never> {
        let parameters: Parameters = [
            "game": "hkrpg",
            "lang": "zh-cn",
            "item_id": roleID,
            "tab_from": "TabOwned",
            "change_target_level": 0,
            "uid": uid,
            "region": "prod_gf_cn"
        ]
                
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.StarRail.avatarDetail.rawValue

        let headers = ApiHeaderConfiguration.baseHeaders(
            region: region,
            additionalHeaders: [
                "Cookie": cookie
            ]
        )
        
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
    
    func featchStarRailRoleList<T: Mappable>(
        with uid: String,
        server: String,
        page: Int
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.StarRail.avatarList.rawValue
        
        let parameters: Parameters = [
            "game": "hkrpg",
            "uid": "102731382",
            "region": "prod_gf_cn",
            "lang": "zh-cn",
            "tab_from": "TabOwned",
            "page": 1,
            "size": 100
        ]

        let headers = ApiHeaderConfiguration.baseHeaders(
            region: region,
            additionalHeaders: ["Cookie": cookie]
        )
        
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
}
