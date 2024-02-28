//
//  Bundle+Extensions.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation

extension Bundle {
    static func getJSONFile(_ fileName: String) -> [String: Any]? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            let jsonData: [String: Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
            return jsonData
        } catch {
            print("\(error)")
        }
        
        return nil
    }
}

extension Dictionary {
    var toJSONString: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
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
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
