//
//  DictionaryX.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation

extension Dictionary {
    func queryString() -> String {
        var parts: [String] = []
        for (key, value) in self {
            let keyString = "\(key)"
            let valueString = "\(value)"
            let escapedKey = keyString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = valueString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(escapedKey)=\(escapedValue)")
        }
        return parts.joined(separator: "&")
    }
}
