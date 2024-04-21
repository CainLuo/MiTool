//
//  DictionaryX.swift
//  
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation

extension Dictionary {
    var toJSONString: String? {
        guard let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: [.prettyPrinted]
        ) else {
            return nil
        }
        return String(data: theJSONData, encoding: .ascii)
    }
}
