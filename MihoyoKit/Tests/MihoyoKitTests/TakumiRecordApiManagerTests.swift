//
//  TakumiRecordApiManagerTests.swift
//  
//
//  Created by Cain Luo on 2024/4/21.
//

import XCTest
import Combine
@testable import MiHoYoKit // 替换为你的模块名称

final class TakumiRecordApiManagerTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var manager: TakumiRecordApiManager!
    
    override func setUp() {
        super.setUp()
        manager = TakumiRecordApiManager.shared
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    func testStarRailWidget() {
        let expect = expectation(description: "starRailWidget completes")
        
        manager.starRailWidget(with: .china)
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }

    func testGenshinWidget() {
        let expect = expectation(description: "genshinWidget completes")
        
        manager.genshinWidget(with: .china)
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }

    func testGenshinRoleList() {
        let expect = expectation(description: "genshinRoleList completes")
        
        manager.genshinRoleList(with: "", roleRegion: "")
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }
}
