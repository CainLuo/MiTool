//
//  ApiDSHelper.swift
//  MiTool
//
//  Created by Cain on 2024/3/11.
//

import Foundation
import CryptoSwift

public enum Region: String {
    case china = "hk4e_cn"
    case global = "hk4e_global"
}

enum ApiDSHelper {
    static func getDS(region: Region, query: String, body: Data? = nil) -> String {
        let salt: String = ApiHeaderConfiguration.salt(region: region)
        
        let time = String(Int(Date().timeIntervalSince1970))
        let randomNumber = String(Int.random(in: 100_000 ..< 200_000))
        
        let bodyString: String
        if let body = body {
            bodyString = String(data: body, encoding: .utf8) ?? ""
        } else {
            bodyString = ""
        }
        
        let verification = "salt=\(salt)&t=\(time)&r=\(randomNumber)&b=\(bodyString)&q=\(query)".md5()
        
        return time + "," + randomNumber + "," + verification
    }
}