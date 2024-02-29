//
//  ApiNetworkManager.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiNetworkManager {
    func getRequest(
        url: URL,
        parameters: Parameters? = nil,
        completionHandler: ((String, AFError?) -> Void)? = nil
    ) {
        AF.request(
            url,
            method: .get,
            parameters: [:],
            headers: [:]
        )
        .response { data in
            switch data.result {
            case .success(let result):
                guard let result = result,
                   let jsonString = String(data: result, encoding: .utf8) else {
                    completionHandler?("Request success, but result is not json", nil)
                    return
                }
                completionHandler?(jsonString, nil)
            case .failure(let error):
                completionHandler?("", error)
            }
        }
    }

    func postReuqest(
        url: URL,
        parameters: Parameters? = nil,
        completionHandler: ((String, AFError?) -> Void)? = nil
    ) {
        AF.request(
            url,
            method: .get,
            parameters: [:],
            headers: [:]
        )
        .response { data in
            switch data.result {
            case .success(let result):
                guard let result = result,
                   let jsonString = String(data: result, encoding: .utf8) else {
                    completionHandler?("Request success, but result is not json", nil)
                    return
                }
                completionHandler?(jsonString, nil)
            case .failure(let error):
                completionHandler?("", error)
            }
        }
    }
}
