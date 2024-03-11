//
//  Bundle+Extensions.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import ObjectMapper

extension Bundle {
    static func getJSONFile<T: Mappable>(
        _ fileName: String,
        responseType: T.Type
    ) -> T? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            Logger.error(message: "File not found: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: filePath)
            let jsonStriing = String(data: data, encoding: .utf8) ?? ""
            return T(JSONString: jsonStriing)
        } catch {
            Logger.error(message: "Error parsing JSON file: \(error)")
            return nil
        }
    }
}

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

extension String {
    var toJSON: [String: Int]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int]
            } catch {
                Logger.error(message: error.localizedDescription)
            }
        }
        return nil
    }
}
