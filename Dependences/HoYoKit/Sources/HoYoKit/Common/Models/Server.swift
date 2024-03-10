//
//  Servers.swift
//
//
//  Created by Bill Haku on 2023/3/26.
//  返回识别服务器信息的工具类

import Foundation

// MARK: - Server

/// The server of an StarRail account.
public enum Server: String, CaseIterable {
    case china = "天空岛"
    case bilibili = "世界树"
    case unitedStates = "America"
    case europe = "Europe"
    case asia = "Asia"
    case hongKongMacauTaiwan = "TW/HK/MO"
}

extension Server {
    /// The region of the server.
    public var region: Region {
        switch self {
        case .bilibili, .china:
            return .mainlandChina
        case .asia, .europe, .hongKongMacauTaiwan, .unitedStates:
            return .global
        }
    }

    public var localized: String { localizedKey.localized }

    public var localizedKey: String {
        switch self {
        case .china:
            return "server.region.name.celestia"
        case .bilibili:
            return "server.region.name.irminsul"
        case .unitedStates:
            return "server.region.name.us"
        case .europe:
            return "server.region.name.eu"
        case .asia:
            return "server.region.name.asia"
        case .hongKongMacauTaiwan:
            return "server.region.name.hongKongMacauTaiwan"
        }
    }

    /// The timezone of the server.
    public func timeZone() -> TimeZone {
        switch self {
        case .asia, .bilibili, .china, .hongKongMacauTaiwan:
            return .init(secondsFromGMT: 8 * 60 * 60) ?? .current
        case .unitedStates:
            return .init(secondsFromGMT: -5 * 60 * 60) ?? .current
        case .europe:
            return .init(secondsFromGMT: 1 * 60 * 60) ?? .current
        }
    }
}

// MARK: Identifiable

extension Server: Identifiable {
    public var id: String {
        switch self {
        case .china:
            return "cn_gf01"
        case .bilibili:
            return "cn_qd01"
        case .unitedStates:
            return "os_usa"
        case .europe:
            return "os_euro"
        case .asia:
            return "os_asia"
        case .hongKongMacauTaiwan:
            return "os_cht"
        }
    }

    public static func id(_ id: String) -> Self {
        switch id {
        case "cn_gf01":
            return .china
        case "cn_qd01":
            return .bilibili
        case "os_usa":
            return .unitedStates
        case "os_euro":
            return .europe
        case "os_asia":
            return .asia
        case "os_cht":
            return .hongKongMacauTaiwan
        default:
            return .china
        }
    }
}

// MARK: Codable

extension Server: Codable {}

// MARK: RawRepresentable

extension Server: RawRepresentable {}

// MARK: CustomStringConvertible

// extension Server: CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case .china:
//            return "星穹列车"
//        case .bilibili:
//            return "无名客"
//        case .unitedStates:
//            return "America"
//        case .europe:
//            return "Europe"
//        case .asia:
//            return "Asia"
//        case .hongKongMacauTaiwan:
//            return "TW/HK/MO"
//        }
//    }
// }
