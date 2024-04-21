//
//  MiHoYoDeviceFPModel.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

struct MiHoYoDeviceFPModel: Mappable {
    var seedId: String?
    var deviceId: String = UUID().uuidString
    var platform: String = "5"
    var seedTime: String = "\(Int(Date().timeIntervalSince1970) * 1000)"
    var extFields: MiHoYoDeviceExtFieldsModel?
    var appName: String = "bbs_cn"
    var deviceFp: String = "38d7ebd3b45ae"
    
    init?(map: Map) {}
    init() {
        self.seedId = generateSeed()
    }
    
    mutating func mapping(map: Map) {
        seedId <- map["seed_id"]
        deviceId <- map["device_id"]
        platform <- map["platform"]
        seedTime <- map["seed_time"]
        extFields <- map["ext_fields"]
        appName <- map["app_name"]
        deviceFp <- map["device_fp"]
    }
    
    private func generateSeed() -> String {
        let characters = "0123456789abcdef"
        var result = ""
        for _ in 0 ..< 16 {
            let randomIndex = Int.random(in: 0 ..< characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            result.append(character)
        }
        return result
    }
}

struct MiHoYoDeviceExtFieldsModel: Mappable {
    var vendor: String = "--"
    var ramCapacity: String = "3662"
    var cpuCores: String = "6"
    var chargeStatus: String = "3"
    var romCapacity: String = "121947"
    var ramRemain: String = "76"
    var accelerometer: String = "0.054596x-0.290237x-0.957809"
    var networkType: String = "WIFI"
    var screenSize: String = "390×844"
    var isJailBreak: String = "0"
    var gyroscope: String = "-0.024806x0.070681x-0.020708"
    var IDFV: String = "275379E1-5FB1-42B9-86D6-F4F80A6CAC2C"
    var proxyStatus: String = "1"
    var magnetometer: String = "-118.163391x-247.904663x-353.548492"
    var batteryStatus: String = "100"
    var cpuType: String = "CPU_TYPE_ARM64"
    var model: String = "iPhone13,2"
    var osVersion: String = "17.1.1"
    var romRemain: String = "3963"
    var appMemory: String = "60"
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        vendor <- map["vendor"]
        ramCapacity <- map["ramCapacity"]
        cpuCores <- map["cpuCores"]
        chargeStatus <- map["chargeStatus"]
        romCapacity <- map["romCapacity"]
        ramRemain <- map["ramRemain"]
        accelerometer <- map["accelerometer"]
        networkType <- map["networkType"]
        screenSize <- map["screenSize"]
        isJailBreak <- map["isJailBreak"]
        gyroscope <- map["gyroscope"]
        IDFV <- map["IDFV"]
        proxyStatus <- map["proxyStatus"]
        magnetometer <- map["magnetometer"]
        batteryStatus <- map["batteryStatus"]
        cpuType <- map["cpuType"]
        model <- map["model"]
        osVersion <- map["osVersion"]
        romRemain <- map["romRemain"]
        appMemory <- map["appMemory"]
    }
}
