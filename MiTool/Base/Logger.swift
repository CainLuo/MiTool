//
//  Logger.swift
//  MiTool
//
//  Created by Cain on 2024/3/11.
//

import Foundation

enum Logger {
    #if DEBUG
    static let enable = true
    #else
    static let enable = false
    #endif
    
    static func info<T>(
        _ message: T,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(
            message,
            prefix: "📚📚📚",
            suffix: "📚📚📚",
            file: file,
            function: function,
            line: line
        )
    }

    static func error<T>(
        _ message: T,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(
            message,
            prefix: "❌❌❌",
            suffix: "❌❌❌",
            file: file,
            function: function,
            line: line
        )
    }

    static func warning<T>(
        _ message: T,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        log(
            message,
            prefix: "⚠️⚠️⚠️",
            suffix: "⚠️⚠️⚠️",
            file: file,
            function: function,
            line: line
        )
    }
    
    private static func log<T>(
        _ message: T,
        prefix: String,
        suffix: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        guard enable else { return }
        #if DEBUG
        // Get FileName
        let fileName = URL(string: file)?.deletingPathExtension().lastPathComponent ?? ""
        let date = Date()
        // Output log message
        let log = "\(prefix) ---------- \(date): \(fileName)(line:\(line)) \(function) |\n\t\(message). ---------- \(suffix)"
        print(log)
        #endif
    }
}
