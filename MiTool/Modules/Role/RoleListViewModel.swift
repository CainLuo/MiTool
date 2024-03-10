//
//  RoleListViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import SwiftUI

class RoleListViewModel: ObservableObject {
    @Published var roleList: [StarRailAllRoleListModel] = []
    @Published var userName: String = ""
    @Published var uid: String = ""

    private let manager = MockApi.shared

    func fetchRoleAllList() {
        let users = SQLManager.shared.getMihoyoUserList()
        for user in users {
            userName = user.nickname
            uid = user.uidString
            fetchRoleInfoList(uid: user.uid)
        }
    }
    
    private func fetchRoleInfoList(uid: String) {
        let localList = SQLManager.shared.getAllStarRailRoleList(uuid: uid)
        roleList = localList
        
        NetworkServerManager.fetchStarRailRoles(uid: uid) { [weak self] _, list in
            self?.roleList = list
        }
    }
}