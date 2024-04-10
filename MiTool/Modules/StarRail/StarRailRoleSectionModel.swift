//
//  StarRailRoleSectionModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/6.
//

import Foundation

struct StarRailRoleSectionModel: Identifiable {
    var id = UUID()
    var uid: String = ""
    var userName: String = ""
    var roleRegion: String = ""
    var items: [StarRailRoleSectionItemModel] = []
}

struct StarRailRoleSectionItemModel: Identifiable {
    var id = UUID()
    var roleItem = StarRailAllRoleListModel()
    var roleInfo = StarRailRoleInfoData()
    var compute: StarRailSkillComputeData?
}
