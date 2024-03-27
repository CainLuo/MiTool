//
//  GenshinRoleViewViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI

class GenshinRoleViewViewModel: BaseViewModel {
    @Published var sections: [GenshinRoleSectionModel] = []
    @Published var reloadMesssage: String = ""
    
    func fetchUserList() {
        let users = SQLManager.shared.getMihoyoUserList()
        for user in users {
            fetchRoleInfoList(uid: user.uid)
        }
    }
    
    private func fetchRoleInfoList(uid: String) {
        var section = GenshinRoleSectionModel()
        SQLManager.shared.getGenshinGameCard(uuid: uid) { item in
            section.userName = item.nickname
            section.uid = item.gameUID
        }

        let locaList = SQLManager.shared.getGenshinCharacter(uuid: uid)
        section.roleList = locaList.sorted { left, right in
            left.rarity ?? 5 > right.rarity ?? 5
        }
        self.sections.append(section)
    }
    
    func reloadGenshinCharacter(uid: String, server: String) {
//        ApiManager.shared.fetchGenshinCharacter(with: uid, server: "cn_gf01")
//            .sink { [weak self] (result: GenshinCharacterModel) in
//                guard let list = result.data?.avatars else {
//                    return
//                }
//                
//                let index = self?.sections.compactMap { $0.uid }.firstIndex(of: uid) ?? 0
//                self?.sections[index].roleList = list
//
//                list.forEach { item in
//                    SQLManager.shared.addGenshinCharacter(uuid: uid, model: item)
//                }
//            }
//            .store(in: &cancellables)
    }
    
    func reloadGenshinCharacterSkills(uid: String, server: String) {
        let section = sections.filter { $0.uid == uid }.first
        guard let list = section?.roleList else {
            return
        }
        list.indices.forEach { index in
            let item = list[index]
            guard let avatarID = item.avatarID else {
                return
            }
            
            if index != list.count - 1 {
                reloadMesssage = "正在获取\(item.name ?? "")的天赋信息"
            } else {
                reloadMesssage = "已完成"
            }
            
            ApiManager.shared.fetchGenshinRoleSkills(uid: uid, server: server, avatarID: avatarID)
                .sink { (result: GenshinRoleSkillModel) in
                    guard let list = result.data?.skillList else {
                        return
                    }
                    SQLManagerHelper().saveGenshinSkills(uid: uid, avatarID: avatarID, skills: list)
                }
                .store(in: &cancellables)
        }
    }
}
