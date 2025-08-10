//
//  Log.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/30/25.
//

import Foundation

enum LogLevel: String {
    case info = "🟢 INFO"
    case warning = "🟠 WARNING"
    case error = "🔴 ERROR"
    case debug = "🔵 DEBUG"
}

struct Log {
    static func print(
        _ message: String,
        level: LogLevel = .info,
        statusCode: Int? = nil,
        url: URL? = nil,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let fileName = (file as NSString).lastPathComponent
        let statusText = statusCode.map { "HTTP \(String($0))" } ?? "No Status"
        let urlText = url?.absoluteString ?? "No URL"
        
        Swift.print("""
               [\(level.rawValue)] \(statusText)
               URL: \(urlText)
               File: \(fileName):\(line)
               Function: \(function)
               → Message:
               \(message)
               """)
    }
}
