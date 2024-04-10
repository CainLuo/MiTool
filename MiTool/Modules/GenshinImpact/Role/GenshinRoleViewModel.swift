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
            section.roleRegion = item.region
        }
        
        fetchLocalRoleList(accountUID: uid, gameUID: section.uid)
            .sink { [weak self] items in
                if items.isNotEmpty {
                    section.items = items
                    self?.sections.append(section)
                } else {
                    self?.fetchRemoteGenshinRoleList(
                        gameUID: section.uid,
                        roleRegion: section.roleRegion
                    )
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchLocalRoleList(accountUID: String, gameUID: String) -> AnyPublisher<[GenshinRoleSectionItemModel], Never> {
        let localList = SQLManager.shared.getGenshinCharacter(uuid: accountUID)
        let localSkills = SQLManager.shared.getGenshinRoleAllSkill(uuid: gameUID)
        let roleIDs = localList.compactMap { $0.avatarID }
        
        return Publishers.Sequence(sequence: localSkills)
            .map { data -> GenshinRoleSectionItemModel in
                guard let roleID = data.roleID,
                      let index = roleIDs.firstIndex(of: roleID) else {
                    fatalError("role id is empty")
                }
                let localRole = localList[index]
                return GenshinRoleSectionItemModel(
                    roleItem: localRole,
                    skillData: GenshinRoleSkillDataModel(skillList: [data])
                )
            }
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func fetchRemoteGenshinRoleList(gameUID: String, roleRegion: String) {
        let sqlHelper = SQLManagerHelper()
        
        ApiManager.shared.fetchGenshinCharacter(with: gameUID, roleRegion: roleRegion)
            .sink { [weak self] (result: GenshinCharacterModel) in
                guard let list = result.data?.avatars else {
                    return
                }
                
                sqlHelper.saveGenshinCharacter(uid: gameUID, list: list)
                self?.reloadGenshinCharacterSkills(uid: gameUID, roleList: list)
            }
            .store(in: &cancellables)
    }
    
    private func reloadGenshinCharacterSkills(uid: String, roleList: [GenshinCharacterAvatar]) {
        let section = sections.first { $0.uid == uid }
        guard let section = section else {
            return
        }
        
        let sqlHelper = SQLManagerHelper()
        
        isDisabled.toggle()
        
        Publishers.Sequence(sequence: roleList)
            .flatMap { roleInfo in
                ApiManager.shared.fetchGenshinRoleSkills(
                   uid: section.uid,
                   roleRegion: section.roleRegion,
                   avatarID: roleInfo.avatarID ?? 0)
                    .map { (roleInfo.avatarID ?? 0, $0) }
            }
            .collect()
            .sink { [weak self] _ in
                self?.isDisabled.toggle()
            } receiveValue: { (result: [(Int, GenshinRoleSkillModel)]) in
                result.forEach { roleID, model in
                    guard let list = model.data?.skillList else {
                        return
                    }
                    sqlHelper.saveGenshinSkills(uid: uid, roleID: roleID, skills: list)
                }
            }
            .store(in: &cancellables)
    }
}
