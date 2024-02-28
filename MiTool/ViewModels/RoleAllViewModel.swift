//
//  RoleAllViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import SwiftUI

class RoleAllViewModel: ObservableObject {
    @Published var roleList: [StarRailAllRoleListModel] = []
    
    private let manager = MockApi.shared

    func fetchRoleAllList() {
        let model = manager.getStarRailAllRoleList()
        guard let roleList = model.data?.list else {
            return
        }
        self.roleList = roleList
    }
}
