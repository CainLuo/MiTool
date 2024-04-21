//
//  StarRailApiManagerTests.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import XCTest
import Combine
@testable import MiHoYoKit

class StarRailApiManagerTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var manager: StarRailApiManager!
    
    override func setUp() {
        super.setUp()
        manager = StarRailApiManager.shared
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }
    
    func testRoleList() {
        let expect = expectation(description: "roleList completes")
        let parameter = StarRailRoleRequestModel(uid: "", region: "", page: 1)
        
        manager.roleList(parameter: parameter)
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }
    
    func testRoleDetail() {
        let expect = expectation(description: "roleDetail completes")
        let parameter = StarRailRoleDetailRequestModel(uid: "", region: "", itemID: "", changeTargetLevel: 0)
        
        manager.roleDetail(parameter: parameter)
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }

    func testRoleSkillCompute() {
        let expect = expectation(description: "roleSkillCompute completes")
        let parameter = StarRailComputeRequestModel(uid: "", region: "")
        
        manager.roleSkillCompute(parameter: parameter)
            .sink { (result: StarRailAllRoleModel) in
                expect.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expect], timeout: 5.0) // 修改超时时间以适应你的需求
    }
}
