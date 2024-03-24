//
//  StringX.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation

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
