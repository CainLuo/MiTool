//
//  StarRailRoleSectionModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/6.
//

import Foundation

struct StarRailRoleSectionModel: Identifiable {
    var id = UUID()
    var roleList: [StarRailAllRoleListModel] = []
    var userName: String = ""
    var uid: String = ""
    var server: String = ""
}
