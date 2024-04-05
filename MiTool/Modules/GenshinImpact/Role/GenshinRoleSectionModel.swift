//
//  GenshinRoleSectionModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation

struct GenshinRoleSectionModel: Identifiable {
    var id = UUID()
    var roleList: [GenshinCharacterAvatar] = []
    var userName: String = ""
    var uid: String = ""
    var server: String = ""
}
