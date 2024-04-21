//
//  StringX.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation

extension String {
    var toJSON: [String: Int]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int]
            } catch {
                Logger.error(error.localizedDescription)
            }
        }
        return nil
    }
}

extension String {
    func sortedURL() -> String {
        return self.split(separator: "&").sorted().joined(separator: "&")
    }
    
    func removeNewlinesAndSpaces() -> String {
        let withoutNewlines = self.replacingOccurrences(of: "\n", with: "")
        let withoutSpaces = withoutNewlines.replacingOccurrences(of: " ", with: "")
        return withoutSpaces
    }
}
