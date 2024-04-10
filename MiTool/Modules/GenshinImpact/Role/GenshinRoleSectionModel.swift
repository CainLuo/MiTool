//
//  GenshinRoleSectionModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation

struct GenshinRoleSectionModel: Identifiable {
    var id = UUID()
    var uid: String = ""
    var userName: String = ""
    var roleRegion: String = ""
    var items: [GenshinRoleSectionItemModel] = []
}

struct GenshinRoleSectionItemModel: Identifiable {
    var id = UUID()
    var roleItem = GenshinCharacterAvatar()
    var skillData: GenshinRoleSkillDataModel?
}
