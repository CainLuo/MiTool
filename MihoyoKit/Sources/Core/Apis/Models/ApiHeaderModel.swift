//
//  ApiHeaderModel.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

struct ApiHeaderModel: Mappable {
    var accept: String?
    var acceptEncoding: String?
    var acceptLanguage: String?
    var connection: String?
    var cookie: String?
    var decodeSalt: String?
    var origin: String?
    var referer: String?
    var secFetchDest: String?
    var secFetchMode: String?
    var secFetchSite: String?
    var userAgent: String?
    var xRequestedWith: String?
    var xRpcAppVersion: String?
    var xRpcClientType: String?
    var xRpcDeviceFP: String?
    var xRpcDeviceID: String?
    var xRpcLanguage: String?
    var xRpcPage: String?

    init?(map: Map) {
        self.init()
    }

    init(
        accept: String? = nil,
        acceptEncoding: String? = nil,
        acceptLanguage: String? = nil,
        connection: String? = nil,
        cookie: String? = nil,
        decodeSalt: String? = nil,
        origin: String? = nil,
        referer: String? = nil,
        secFetchDest: String? = nil,
        secFetchMode: String? = nil,
        secFetchSite: String? = nil,
        userAgent: String? = nil,
        xRequestedWith: String? = nil,
        xRpcAppVersion: String? = nil,
        xRpcClientType: String? = nil,
        xRpcDeviceFP: String? = nil,
        xRpcDeviceID: String? = nil,
        xRpcLanguage: String? = nil,
        xRpcPage: String? = nil
    ) {

        self.userAgent = userAgent
        self.referer = referer
        self.origin = origin
        self.acceptEncoding = acceptEncoding
        self.acceptLanguage = acceptLanguage
        self.accept = accept
        self.connection = connection
        self.xRpcAppVersion = xRpcAppVersion
        self.xRpcClientType = xRpcClientType
        self.xRpcPage = xRpcPage
        self.xRpcLanguage = xRpcLanguage
        self.secFetchDest = secFetchDest
        self.secFetchSite = secFetchSite
        self.secFetchMode = secFetchMode
        self.decodeSalt = decodeSalt
        self.cookie = cookie
        self.xRpcDeviceFP = xRpcDeviceFP
        self.xRpcDeviceID = xRpcDeviceID
        self.xRequestedWith = xRequestedWith
    }

    mutating func mapping(map: Map) {
        accept <- map["accept"]
        acceptEncoding <- map["accept-encoding"]
        acceptLanguage <- map["accept-langauge"]
        connection <- map["connection"]
        cookie <- map["cookie"]
        decodeSalt <- map["decodeSalt"]
        origin <- map["origin"]
        referer <- map["referer"]
        secFetchDest <- map["sec-fetch-dest"]
        secFetchMode <- map["sec-fetch-mode"]
        secFetchSite <- map["sec-fetch-site"]
        userAgent <- map["User-Agent"]
        xRequestedWith <- map["x-requested-with"]
        xRpcAppVersion <- map["x-rpc-app_version"]
        xRpcClientType <- map["x-rpc-client_type"]
        xRpcDeviceFP <- map["x-rpc-device_fp"]
        xRpcDeviceID <- map["x-rpc-device_id"]
        xRpcLanguage <- map["x-rpc-language"]
        xRpcPage <- map["x-rpc-page"]
    }
}
