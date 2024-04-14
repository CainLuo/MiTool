//
//  StarRailRoleListViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import Combine

class StarRailRoleListViewModel: BaseViewModel {
    @Published var sections: [StarRailRoleSectionModel] = []
    @Published var userName: String = ""
    @Published var uid: String = ""
    
    private var remotePage = 1

    func fetchRoleAllList() {
        let users = SQLManager.shared.getMihoyoUserList()
        users.forEach { _ in
            fetchRoleInfoList()
        }
    }
    
    private func fetchRoleInfoList() {
        SQLManager.shared.getMihoyoGames()
            .sink { [weak self] games in
                let starRailAccounts = games.filter { $0.gameBiz.contains("hkrpg") }
                starRailAccounts.forEach { gameItem in
                    self?.setupSections(gameItem: gameItem)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupSections(gameItem: MihoyoGamesItemModel) {
        var section = StarRailRoleSectionModel()
        fetchLocalData(gameUID: gameItem.gameUID, roleRegion: gameItem.region)
            .sink { [weak self] items in
                if items.isNotEmpty {
                    section.items = items
                    self?.sections.append(section)
                } else {
                    self?.fetchRemoteRoleList(
                        gameUID: gameItem.gameUID,
                        gameRegion: gameItem.region,
                        page: self?.remotePage ?? 1
                    )
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchLocalData(gameUID: String, roleRegion: String) -> AnyPublisher<[StarRailRoleSectionItemModel], Never> {
        let locaList = SQLManager.shared.getAllStarRailRoleList(uuid: gameUID)
        let computeList = SQLManager.shared.getAllStarRailRoleComputeList(gameUID)
        let roleIDs = locaList.compactMap { $0.itemID }
        
        return Publishers.Sequence(sequence: locaList)
            .map { [weak self] data -> StarRailRoleSectionItemModel in
                guard let roleID = data.itemID,
                      let index = roleIDs.firstIndex(of: roleID) else {
                    fatalError("role id is empty")
                }
                let localRole = locaList[index]
                let compute = computeList.first(where: { $0.roleID == localRole.itemID })
                let localCompute = computeList.isEmpty ? nil : compute
                
                if localCompute == nil {
                    self?.fetchRemoteRoleDetail(uid: gameUID, roleID: roleID, roleRegion: roleRegion)
                }
                
                return StarRailRoleSectionItemModel(roleItem: localRole, compute: localCompute)
            }
            .collect()
            .eraseToAnyPublisher()
    }

    private func fetchRemoteRoleList(gameUID: String, gameRegion: String, page: Int) {
        ApiManager.shared.featchStarRailRoleList(with: gameUID, roleRegion: gameRegion, page: page)
            .sink { [weak self] (result: StarRailAllRoleModel) in
                guard let list = result.data?.list,
                      list.isNotEmpty else {
                    self?.fetchRoleAllList()
                    return
                }
                SQLManagerHelper.saveStarRailRoleDetail(uid: gameUID, list: list)
                self?.remotePage += 1
                self?.fetchRemoteRoleList(gameUID: gameUID, gameRegion: gameRegion, page: self?.remotePage ?? 1)
            }
            .store(in: &cancellables)
    }
    
    private func fetchRemoteRoleDetail(uid: String, roleID: String, roleRegion: String) {
        ApiManager.shared.fetchStarRailRoleDetail(with: uid, roleID: roleID, roleRegion: roleRegion)
            .sink { [weak self] (result: StarRailRoleInfoModel) in
                guard let data = result.data else {
                    return
                }
                SQLManagerHelper.addStarRailRoleSkill(uid: uid, info: data)
                self?.fetchRemoteRoleCompute(uid: uid, roleRegion: roleRegion, role: data)
            }
            .store(in: &cancellables)
    }

    private func fetchRemoteRoleCompute(
        uid: String,
        roleRegion: String,
        role: StarRailRoleInfoData
    ) {
        let parameters = StarRailComputeRequestModel(role: role, roleRegion: roleRegion)
        let sectionIndex = sections.firstIndex { $0.uid == uid } ?? 0
        let itemIndex = sections[sectionIndex].items.firstIndex { $0.roleItem.itemID == role.avatar?.itemID ?? "" } ?? 0
        
        ApiManager.shared.fetchStarRailRoleSkillCompute(with: parameters)
            .sink { [weak self] (result: StarRailSkillComputeModel) in
                guard let data = result.data else {
                    return
                }
                self?.sections[sectionIndex].items[itemIndex].compute = data
                SQLManagerHelper().addStarRailRoleCompute(
                    uid: uid,
                    roleID: role.avatar?.itemID ?? "",
                    info: data
                )
            }
            .store(in: &cancellables)
    }
}
