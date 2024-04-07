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
        with request: StarRailComputeRequestModel
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
        roleID: String,
        roleRegion: String
    ) -> AnyPublisher<T, Never> {
        let parameters: Parameters = StarRailRoleDetailRequestModel(
            uid: uid,
            region: roleRegion,
            itemID: roleID,
            changeTargetLevel: 0).toJSON()
                
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
        roleRegion: String,
        page: Int
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.StarRail.avatarList.rawValue
        
        let parameters: Parameters = StarRailRoleRequestModel(uid: uid, region: roleRegion, page: page).toJSON()
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
