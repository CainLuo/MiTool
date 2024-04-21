//
//  LanguageManager.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation

class LanguageManager {
    /// Get the language type based on language code and region code
    /// - Returns: String
    static func getLowLang() -> String {
        let identifier = Locale.current.identifier.lowercased()
        if identifier.contains("_") {
            return identifier.replacingOccurrences(of: "_", with: "-")
        } else {
            return identifier
        }
    }
    
    static func getUpLang() -> String {
        let identifier = Locale.current.identifier
        if identifier.contains("_") {
            return identifier.replacingOccurrences(of: "_", with: "-")
        } else {
            return identifier
        }
    }
}
