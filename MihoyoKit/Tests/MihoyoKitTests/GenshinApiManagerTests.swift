//
//  GenshinApiManagerTests.swift
//  
//
//  Created by Cain Luo on 2024/4/22.
//

import XCTest
import Combine
@testable import MiHoYoKit

final class GenshinApiManagerTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var apiManager: GenshinApiManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiManager = GenshinApiManager.shared
    }
    
    override func tearDownWithError() throws {
        apiManager = nil
        try super.tearDownWithError()
    }
    
    func testFetchGenshinRoleSkills() throws {
        let expectation = XCTestExpectation(description: "Fetch Role Skills")
        let parameters = GenshinRoleSkillsRequestModel()
        
        apiManager.fetchGenshinRoleSkills(with: parameters)
            .sink { (result: GenshinRoleSkillModel) in
                expectation.fulfill()
                XCTAssertNotNil(result, "Response should not be nil")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchGensinWeaponList() throws {
        let expectation = XCTestExpectation(description: "Fetch Weapon List")
        
        apiManager.fetchGensinWeaponList(page: 1)
            .sink { (result: GenshinWeaponModel) in
                expectation.fulfill()
                XCTAssertNotNil(result, "Response should not be nil")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchGensinWeaponCompute() throws {
        let expectation = XCTestExpectation(description: "Fetch Weapon Compute")
        let parameters = GenshinComputeRequestModel()
        
        apiManager.fetchGensinWeaponCompute(with: parameters)
            .sink { (result: GenshinWeaponComputeModel) in
                expectation.fulfill()
                XCTAssertNotNil(result, "Response should not be nil")
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
