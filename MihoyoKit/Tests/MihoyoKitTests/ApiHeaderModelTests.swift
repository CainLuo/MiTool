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
        userAgent: "UserAgent",
        referer: "Referer",
        origin: "Origin",
        acceptEncoding: "AcceptEncoding",
        acceptLanguage: "AcceptLanguage",
        accept: "Accept",
        connection: "Connection",
        xRpcAppVersion: "XRpcAppVersion",
        xRpcClientType: "XRpcClientType",
        xRpcPage: "XRpcPage",
        xRpcLanguage: "XRpcLanguage",
        secFetchDest: "SecFetchDest",
        secFetchSite: "SecFetchSite",
        secFetchMode: "SecFetchMode"
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
