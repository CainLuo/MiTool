//
//  GenshinRoleViewViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI
import Combine

class GenshinRoleViewViewModel: BaseViewModel {
    @Published var sections: [GenshinRoleSectionModel] = []
    @Published var reloadMesssage: String = ""
    
    @State var isDisabled = true
    
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
        isDisabled.toggle()
        list.publisher
            .map { item -> (Int?, AnyPublisher<GenshinRoleSkillModel, Never>) in
                return (item.avatarID,
                        ApiManager.shared.fetchGenshinRoleSkills(
                            uid: uid,
                            server: server,
                            avatarID: item.avatarID ?? 0
                        )
                            .eraseToAnyPublisher()
                )
            }
            .collect()
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isDisabled.toggle()
                },
                receiveValue: { values in
                    print("收到的所有值：", values)
                }
            )
            .store(in: &cancellables)
    }
}
