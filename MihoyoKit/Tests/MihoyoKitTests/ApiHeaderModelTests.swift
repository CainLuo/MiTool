//
//  ApiHeaderModelTests.swift
//  
//
//  Created by Cain Luo on 2024/4/21.
//

import XCTest
@testable import MiHoYoKit

final class ApiHeaderModelTests: XCTestCase {
    var apiHeaderModel: ApiHeaderModel!

    override func setUp() {
      super.setUp()
      apiHeaderModel = ApiHeaderModel(
        accept: "Accept", 
        acceptEncoding: "AcceptEncoding",
        acceptLanguage: "AcceptLanguage",
        connection: "Connection",
        origin: "Origin",
        referer: "Referer", 
        secFetchDest: "SecFetchDest",
        secFetchMode: "SecFetchMode", 
        secFetchSite: "SecFetchSite",
        userAgent: "UserAgent",
        xRpcAppVersion: "XRpcAppVersion",
        xRpcClientType: "XRpcClientType",
        xRpcLanguage: "XRpcLanguage", 
        xRpcPage: "XRpcPage"
      )
    }

    override func tearDown() {
      apiHeaderModel = nil
      super.tearDown()
    }

    func testApiHeaderModel() {
      XCTAssertEqual(apiHeaderModel.userAgent, "UserAgent")
      XCTAssertEqual(apiHeaderModel.referer, "Referer")
      XCTAssertEqual(apiHeaderModel.origin, "Origin")
      XCTAssertEqual(apiHeaderModel.acceptEncoding, "AcceptEncoding")
      XCTAssertEqual(apiHeaderModel.acceptLanguage, "AcceptLanguage")
      XCTAssertEqual(apiHeaderModel.accept, "Accept")
      XCTAssertEqual(apiHeaderModel.connection, "Connection")
      XCTAssertEqual(apiHeaderModel.xRpcAppVersion, "XRpcAppVersion")
      XCTAssertEqual(apiHeaderModel.xRpcClientType, "XRpcClientType")
      XCTAssertEqual(apiHeaderModel.xRpcPage, "XRpcPage")
      XCTAssertEqual(apiHeaderModel.xRpcLanguage, "XRpcLanguage")
      XCTAssertEqual(apiHeaderModel.secFetchDest, "SecFetchDest")
      XCTAssertEqual(apiHeaderModel.secFetchSite, "SecFetchSite")
      XCTAssertEqual(apiHeaderModel.secFetchMode, "SecFetchMode")
    }
}
