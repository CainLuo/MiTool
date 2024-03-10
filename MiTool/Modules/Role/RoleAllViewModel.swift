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
        NetworkServerManager.fetchStarRailRoles(uid: "") { [weak self] _, list in
            self?.roleList = list
        }
    }
}
