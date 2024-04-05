//
//  GenshinRoleViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI
import Combine

class GenshinRoleViewModel: BaseViewModel {
    @Published var sections: [GenshinRoleSectionModel] = []
    @Published var reloadMesssage: String = ""
    
    @Published var isDisabled = true
    
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
            left.rarity.rawValue > right.rarity.rawValue
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
    
    func reloadGenshinCharacterSkills(uid: String) {
//        let section = sections.first { $0.uid == uid }
//        guard let section = section else {
//            return
//        }
//        isDisabled.toggle()
//        section.roleList.publisher
//            .map { item -> (Int?, AnyPublisher<GenshinRoleSkillModel, Never>) in
//                return (item.avatarID,
//                        ApiManager.shared.fetchGenshinRoleSkills(
//                            uid: section.uid,
//                            server: section.server,
//                            avatarID: item.avatarID ?? 0
//                        )
//                            .eraseToAnyPublisher()
//                )
//            }
//            .collect()
//            .sink(
//                receiveCompletion: { [weak self] _ in
//                    self?.isDisabled.toggle()
//                },
//                receiveValue: { values in
//                    print("收到的所有值：", values)
//                }
//            )
//            .store(in: &cancellables)
    }
}
