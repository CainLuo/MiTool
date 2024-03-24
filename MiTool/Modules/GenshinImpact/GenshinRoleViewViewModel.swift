//
//  GenshinRoleViewViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI

class GenshinRoleViewViewModel: BaseViewModel {
    @Published var sections: [GenshinRoleSectionModel] = []
    
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
}
