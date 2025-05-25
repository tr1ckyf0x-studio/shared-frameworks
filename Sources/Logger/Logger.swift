//
//  Logger.swift
//  Logger
//
//  Created by Vladislav Lisianskii on 25. 5. 2025..
//

public protocol Logger {
    func logError(message: String)
    func logDebug(message: String)
    func logInfo(message: String)
    func logVerbose(message: String)
}

public protocol HasLogger {
    var logger: Logger? { get }
}
