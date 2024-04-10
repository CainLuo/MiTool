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
        for user in users {
            fetchRoleInfoList(uid: user.uid)
        }
    }
    
    private func fetchRoleInfoList(uid: String) {
        var section = StarRailRoleSectionModel()
        SQLManager.shared.getStarRailGameCard(uuid: uid) { item in
            section.userName = item.nickname
            section.uid = item.gameUID
            section.roleRegion = item.region
        }
        
        fetchLocalData(accountUID: uid, gameUID: section.uid)
            .sink { [weak self] items in
                if items.isNotEmpty {
                    section.items = items
                    self?.sections.append(section)
                } else {
                    self?.fetchRemoteRoleList(
                        gameUID: section.uid,
                        gameRegion: section.roleRegion,
                        page: self?.remotePage ?? 1
                    )
                    self?.remotePage += 1
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchLocalData(accountUID: String, gameUID: String) -> AnyPublisher<[StarRailRoleSectionItemModel], Never> {
        let locaList = SQLManager.shared.getAllStarRailRoleList(uuid: accountUID)
        let compute = SQLManager.shared.getAllStarRailRoleComputeList(gameUID)
        let roleIDs = locaList.compactMap { $0.itemID }
        
        return Publishers.Sequence(sequence: compute)
            .map { data -> StarRailRoleSectionItemModel in
                guard let roleID = data.roleID,
                      let index = roleIDs.firstIndex(of: roleID) else {
                    fatalError("role id is empty")
                }
                let localRole = locaList[index]
                return StarRailRoleSectionItemModel(roleItem: localRole, compute: data)
            }
            .collect()
            .eraseToAnyPublisher()
    }

    private func fetchRemoteRoleList(gameUID: String, gameRegion: String, page: Int) {
        ApiManager.shared.featchStarRailRoleList(with: gameUID, roleRegion: gameRegion, page: page)
            .sink { [weak self] (result: StarRailAllRoleModel) in
                guard let list = result.data?.list else {
                    self?.fetchRoleAllList()
                    return
                }
                SQLManagerHelper.saveStarRailRoleDetail(uid: gameUID, list: list)
                self?.fetchRemoteRoleList(gameUID: gameUID, gameRegion: gameRegion, page: page)
            }
            .store(in: &cancellables)
    }

    private func featchRemoteRoleCompute(
        uid: String,
        roleRegion: String,
        role: StarRailRoleInfoData
    ) {
        let section = sections.first { $0.uid == uid }
        let filterRole = section?.items.first { $0.roleInfo.avatar?.itemID == role.avatar?.itemID ?? "" }
        guard var filterRole else {
            return
        }

        let parameters = StarRailComputeRequestModel(role: role, roleRegion: roleRegion)

        ApiManager.shared.fetchStarRailRoleSkillCompute(with: parameters)
            .sink { (result: StarRailSkillComputeModel) in
                guard let data = result.data else {
                    return
                }
                filterRole.compute = data
                SQLManagerHelper().addStarRailRoleCompute(
                    uid: uid,
                    roleID: role.avatar?.itemID ?? "",
                    info: data
                )
            }
            .store(in: &cancellables)
    }
}

//extension StarRailRoleListViewModel {
//    private func fetchRemoteRoleList(uid: String, roleRegion: String, roleList: [StarRailAllRoleListModel]) {
//        Publishers.Sequence(sequence: roleList)
//            .flatMap {
//                self.fetchRemoteRoleDetailPublisher(uid: uid, roleID: $0.itemID ?? "", roleRegion: roleRegion)
//            }
//            .collect()
//            .sink(receiveCompletion: { _ in
//                // 所有请求完成后的操作
//                print("All role detail requests completed")
//            }, receiveValue: { _ in
//                // 可选：处理收集到的数据
//            })
//            .store(in: &cancellables)
//    }
//
//    private func fetchRemoteRoleDetailPublisher(uid: String, roleID: String, roleRegion: String) -> AnyPublisher<Void, Never> {
//        ApiManager.shared.fetchStarRailRoleDetail(with: uid, roleID: roleID, roleRegion: roleRegion)
//            .tryMap { (result: StarRailRoleInfoModel) in
//                guard let data = result.data else {
//                    return
//                }
//                SQLManagerHelper.saveStarRailRoleSkill(uid: uid, roleID: roleID, info: data)
//            }
//            .map { _ in }
//            .replaceError(with: ())
//            .eraseToAnyPublisher()
//    }
//}
