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
    
    static let regions = [
        Region.china: "China",
        Region.global: "Global"
    ]
    
    static func region(_ regionString: String) -> Region {
        let regionSever = Region.regions.filter { $0.value == regionString }.compactMap { $0.key }
        guard let region = regionSever.first else {
            return .china
        }
        return region
    }
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
    
    static func getDS1() -> String {
        let lettersAndNumbers = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

        // 将要使用的 salt，此为 2.63.1 版本的 K2 salt。
        let salt = "BIPaooxbWZW02fGHZL1If26mYCljPgst"

        let time = Int(Date().timeIntervalSince1970)
        let randomNumber = String((0..<6).compactMap { _ in lettersAndNumbers.randomElement() })
        let main = "salt=\(salt)&t=\(time)&r=\(randomNumber)"

        if let data = main.data(using: .utf8) {
            let decodeSalt = data.md5().map { String(format: "%02hhx", $0) }.joined()

            let final = "\(time),\(randomNumber),\(decodeSalt)"
            Logger.info(final)
            return final
        }
       return ""
    }
}
