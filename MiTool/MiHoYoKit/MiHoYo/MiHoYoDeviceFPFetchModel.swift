//
//  MihoyoDeviceFPFetchModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import ObjectMapper

public struct MihoyoDeviceFPFetchModel: Mappable {
    public var appName: String = ""
    public var platform: String = ""
    public var seedId: String = ""
    public var extFields: [String: String] = [:]
    public var seedTime: String = ""
    public var deviceFp: String = ""
    public var deviceId: String = ""

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        appName <- map["app_name"]
        platform <- map["platform"]
        seedId <- map["seed_id"]
        extFields <- map["ext_fields"]
        seedTime <- map["seed_time"]
        deviceFp <- map["device_fp"]
        deviceId <- map["device_id"]
    }
}
