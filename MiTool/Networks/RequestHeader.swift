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
    let mysVersion = "2.60.1"
    let saltDictionary: [String: Any] = [
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
        return String((0..<num).compactMap { _ in characters.randomElement() })
    }

    func randomStrDS(
        salt: String,
        sets: String = "abcdefghijklmnopqrstuvwxyz0123456789",
        withBody: Bool = false,
        query: String = "",
        body: [String: Any]? = nil
    ) -> String {
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let randomString = String((0..<6).map { _ in sets.randomElement() ?? Character(" ") })
        var queryString = "salt=\(salt)&t=\(timestamp)&r=\(randomString)"

        if withBody,
           let body = body,
           let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []),
           let bodyString = String(data: jsonData, encoding: .utf8) {
            queryString += "&b=\(bodyString)&q=\(query)"
        }

        let checksum = md5(text: queryString)
        return "\(timestamp),\(randomString),\(checksum)"
    }

    func randomIntDS(
        salt: String,
        query: String = "",
        body: [String: Any]? = nil
    ) -> String {
        let bodyString = body.flatMap { try? JSONSerialization.data(withJSONObject: $0, options: []) }
            .flatMap { String(data: $0, encoding: .utf8) } ?? ""
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let randomValue = String(Int.random(in: 100000...200000))
        let checksum = md5(text: "salt=\(salt)&t=\(timestamp)&r=\(randomValue)&b=\(bodyString)&q=\(query)")
        return "\(timestamp),\(randomValue),\(checksum)"
    }

    func getDSToken(
        query: String = "",
        body: [String: Any]? = nil,
        saltId: String = "25"
    ) -> String {
        guard let sign = saltDictionary[mysVersion] as? [String: String],
              let salt = sign[saltId] else {
            return ""
        }
        return randomIntDS(
            salt: salt,
            query: query,
            body: body
        )
    }

    func getWebDSToken(web: Bool = false) -> String {
        guard let sign = saltDictionary[mysVersion] as? [String: String] else {
            return ""
        }
        return randomStrDS(salt: web ? sign["LK2"] ?? "" : sign["K2"] ?? "")
    }

    func generateOSDS(salt: String = "") -> String {
        guard let osKey = saltDictionary["os"] as? String else {
            return ""
        }
        return randomStrDS(
            salt: salt.isEmpty ? osKey : salt,
            sets: "abcdefghijklmnopqrstuvwxyz"
        )
    }

    func generatePassportDS(
        query: String = "",
        body: [String: Any]? = nil
    ) -> String {
        guard let pdKey = saltDictionary["PD"] as? String else {
            return ""
        }
        return randomStrDS(
            salt: pdKey,
            sets: "abcdefghijklmnopqrstuvwxyz",
            withBody: true,
            query: query,
            body: body
        )
    }

    func hmacSHA256(
        data: String,
        key: String
    ) -> String {
        guard let keyData = key.data(using: .utf8),
              let messageData = data.data(using: .utf8) else {
            return ""
        }

        let hmac = HMAC(
            key: keyData.bytes,
            variant: .sha2(.sha256)
        )
        do {
            let auth = try hmac.authenticate(messageData.bytes)
            return auth.toHexString()
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
