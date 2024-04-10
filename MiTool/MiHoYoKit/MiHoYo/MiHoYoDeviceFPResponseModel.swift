//
//  MihoyoDeviceFPFetchModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import ObjectMapper

public struct MihoyoDeviceFPResponseModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: MihoyoDeviceFPResponseDataModel?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public struct MihoyoDeviceFPResponseDataModel: MihoyoDataModelProtocol {
    public var id = UUID()
    public var deviceFp: String = ""
    public var code: Int = 0
    public var msg: String = ""

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        deviceFp <- map["device_fp"]
        code <- map["code"]
        msg <- map["msg"]
    }
}
