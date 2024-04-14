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
    
    private let helper = SQLManagerHelper()
    
    func fetchUserList() {
        let users = SQLManager.shared.getMihoyoUserList()
        users.forEach { _ in
            fetchRoleInfoList()
        }
    }
    
    private func fetchRoleInfoList() {
        SQLManager.shared.getMihoyoGames()
            .sink { [weak self] games in
                let genshinAccounts = games.filter { $0.gameBiz.contains("hk4e") }
                genshinAccounts.forEach { gameItem in
                    self?.setupSections(gameItem: gameItem)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupSections(gameItem: MihoyoGamesItemModel) {
        var section = GenshinRoleSectionModel()
        fetchLocalRoleList(gameUID: gameItem.gameUID, roleRegion: gameItem.region)
            .sink { [weak self] items in
                if items.isNotEmpty {
                    section.items = items
                    self?.sections.append(section)
                } else {
                    self?.fetchRemoteGenshinRoleList(
                        gameUID: gameItem.gameUID,
                        roleRegion: gameItem.region
                    )
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchLocalRoleList(
        gameUID: String,
        roleRegion: String
    ) -> AnyPublisher<[GenshinRoleSectionItemModel], Never> {
        let localList = SQLManager.shared.getGenshinCharacter(uuid: gameUID)
        let roleIDs = localList.compactMap { $0.avatarID }
        
        return Publishers.Sequence(sequence: localList)
            .map { data -> GenshinRoleSectionItemModel in
                guard let roleID = data.avatarID,
                      let index = roleIDs.firstIndex(of: roleID) else {
                    fatalError("role id is empty")
                }
                let localRole = localList[index]
                return GenshinRoleSectionItemModel(roleItem: localRole)
            }
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func fetchRemoteGenshinRoleList(gameUID: String, roleRegion: String) {
        ApiManager.shared.fetchGenshinCharacter(with: gameUID, roleRegion: roleRegion)
            .sink { [weak self] (result: GenshinCharacterModel) in
                guard let list = result.data?.avatars else {
                    return
                }
                self?.helper.saveGenshinCharacter(uid: gameUID, list: list)
                self?.reloadGenshinCharacterSkills(gameUID: gameUID, roleRegion: roleRegion, roleList: list)
            }
            .store(in: &cancellables)
    }
    
    private func reloadGenshinCharacterSkills(
        gameUID: String,
        roleRegion: String,
        roleList: [GenshinCharacterAvatar]
    ) {
        isDisabled.toggle()
        
        Publishers.Sequence(sequence: roleList)
            .flatMap { roleInfo in
                ApiManager.shared.fetchGenshinRoleSkills(
                    gameUID: gameUID,
                    roleRegion: roleRegion,
                    avatarID: roleInfo.avatarID ?? 0)
                .map { (roleInfo.avatarID ?? 0, $0) }
            }
            .collect()
            .sink { [weak self] _ in
                self?.isDisabled.toggle()
                self?.fetchRoleInfoList()
            } receiveValue: { [weak self] (result: [(Int, GenshinRoleSkillModel)]) in
                result.forEach { roleID, model in
                    guard let list = model.data?.skillList else {
                        return
                    }
                    self?.helper.saveGenshinSkills(uid: gameUID, roleID: roleID, skills: list)
                }
            }
            .store(in: &cancellables)
    }
}
