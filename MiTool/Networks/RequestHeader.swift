//
//  RequestHeader.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import CommonCrypto
import CryptoSwift

struct RequestHeader {
    let mys_version = "2.60.1"
    let _S: [String: Any] = [
        "2.60.1": [
            "K2": "AcpNVhfh0oedCobdCyFV8EE1jMOVDy9q",
            "LK2": "1OJyMNCqFlstEQqqMOv0rKCIdTOoJhNt",
            "22": "t0qEgfub6cvueAPgR5m9aQWWVciEer7v",
            "25": "xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs"
        ],
        "os": "6cqshh5dhw73bzxn20oexa9k516chk7s",
        "PD": "JwYDpKvLj6MrMqqYU6jTKF17KNO2PXoS"
    ]
    
    func md5(text: String) -> String {
        return text.md5()
    }
    
    func randomText(num: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<num).map { _ in characters.randomElement()! })
    }
    
    func randomStrDS(salt: String, 
                     sets: String = "abcdefghijklmnopqrstuvwxyz0123456789",
                     withBody: Bool = false,
                     q: String = "",
                     b: [String: Any]? = nil) -> String {
        let i = String(Int(Date().timeIntervalSince1970))
        let r = String((0..<6).map { _ in sets.randomElement()! })
        var s = "salt=\(salt)&t=\(i)&r=\(r)"
        if withBody {
            s += "&b=\(b != nil ? String(data: try! JSONSerialization.data(withJSONObject: b!, options: []), encoding: .utf8)! : "")&q=\(q)"
        }
        let c = md5(text: s)
        
//        1709018360,140875,fc6c6e063ccd31ce3a95a31e5bd5c05f
//        1709020824,v07lqr,5281842e20d0723a1d05376c3996d90e
        return "\(i),\(r),\(c)"
    }
    
    func randomIntDS(salt: String, 
                     q: String = "",
                     b: [String: Any]? = nil) -> String {
        let br = b != nil ? String(data: try! JSONSerialization.data(withJSONObject: b!, options: []), encoding: .utf8)! : ""
        let s = salt
        let t = String(Int(Date().timeIntervalSince1970))
        let r = String(Int.random(in: 100000...200000))
        let c = md5(text: "salt=\(s)&t=\(t)&r=\(r)&b=\(br)&q=\(q)")
        return "\(t),\(r),\(c)"
    }
    
    func getDSToken(q: String = "", 
                    b: [String: Any]? = nil,
                    saltId: String = "25") -> String {
        guard let sign = _S[mys_version] as? [String: String],
              let salt = sign[saltId] else {
            return ""
        }
        return randomIntDS(salt: salt, q: q, b: b)
    }
    
    func getWebDSToken(web: Bool = false) -> String {
        guard let sign = _S[mys_version] as? [String: String] else {
            return ""
        }
        return randomStrDS(salt: web ? sign["LK2"] ?? "" : sign["K2"] ?? "")
    }
    
    func generateOSDS(salt: String = "") -> String {
        guard let os = _S["os"] as? String else {
            return ""
        }
        return randomStrDS(salt: salt.isEmpty ? os : salt, 
                           sets: "abcdefghijklmnopqrstuvwxyz")
    }
    
    func generatePassportDS(q: String = "", 
                            b: [String: Any]? = nil) -> String {
        guard let pd = _S["PD"] as? String else {
            return ""
        }
        return randomStrDS(salt: pd,
                           sets: "abcdefghijklmnopqrstuvwxyz",
                           withBody: true,
                           q: q,
                           b: b)
    }
    
    func hmacSHA256(data: String, 
                    key: String) -> String {
        do {
            let keyData = key.data(using: .utf8)!
            let messageData = data.data(using: .utf8)!
            let hmac = try HMAC(key: keyData.bytes,
                                variant: .sha2(.sha256)).authenticate(messageData.bytes)
            return hmac.toHexString()
        } catch {
            print("Error calculating HMAC-SHA256: \(error)")
            return ""
        }
    }
    
    func genPaymentSign(data: [String: Any]) -> String {
        let sortedData = data.sorted { $0.key < $1.key }
        let value = sortedData.map { "\($0.value)" }.joined()
        let sign = hmacSHA256(data: value, key: "6bdc3982c25f3f3c38668a32d287d16b")
        return sign
    }
}
