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

        var locaList = SQLManager.shared.getAllStarRailRoleList(uuid: uid)
        for role in locaList {
            SQLManager.shared.getStarRailRoleCompute(section.uid, roleID: role.itemID ?? "")
                .sink { data in
                    let index = locaList.firstIndex { $0.itemID == role.itemID } ?? 0
                    locaList[index].compute = data
                }
                .store(in: &cancellables)
        }

        if locaList.isEmpty {
            ApiManager.shared.featchStarRailRoleList(with: section.uid, roleRegion: section.roleRegion, page: 1)
                .sink { [weak self] (result: StarRailAllRoleModel) in
                    guard let list = result.data?.list else {
                        return
                    }
                    let index = self?.sections.firstIndex { $0.uid == section.uid } ?? 0
                    self?.sections[index].roleList = list
                    SQLManagerHelper.saveStarRailRoleDetail(uid: section.uid, list: list)
                }
                .store(in: &cancellables)
        }

        let localSkill = SQLManager.shared.getAllStarRailRoleSkillList(uuid: section.uid)

        if localSkill.isEmpty {
            fetchRoleList(uid: section.uid, roleRegion: section.roleRegion, roleList: section.roleList)
        }

        let localCompute = SQLManager.shared.getAllStarRailRoleComputeList(uuid: section.uid)
        
        if localCompute.isEmpty {
            for role in localSkill {
                featchRoleCompute(uid: section.uid, roleRegion: section.roleRegion, role: role)
            }
        }
        
        let sortedList = locaList.sorted { left, right in
            left.rarity.rawValue > right.rarity.rawValue
        }
        let finished = sortedList.filter {
            $0.compute?.avatarConsume?.isEmpty == true &&
            $0.compute?.skillConsume?.isEmpty == true &&
            $0.compute?.equipmentConsume?.isEmpty == true
        }
        let notFinished = sortedList.filter {
            $0.compute?.avatarConsume?.isNotEmpty == true ||
            $0.compute?.skillConsume?.isNotEmpty == true ||
            $0.compute?.equipmentConsume?.isNotEmpty == true
        }

        section.roleList = notFinished + finished
        sections.append(section)
    }
    
    private func fetchRoleList(uid: String, roleRegion: String, roleList: [StarRailAllRoleListModel]) {
        Publishers.Sequence(sequence: roleList)
            .flatMap {
                self.fetchRoleDetailPublisher(uid: uid, roleID: $0.itemID ?? "", roleRegion: roleRegion)
            }
            .collect()
            .sink(receiveCompletion: { _ in
                // 所有请求完成后的操作
                print("All role detail requests completed")
            }, receiveValue: { _ in
                // 可选：处理收集到的数据
            })
            .store(in: &cancellables)
    }
    
    private func fetchRoleDetailPublisher(uid: String, roleID: String, roleRegion: String) -> AnyPublisher<Void, Never> {
        ApiManager.shared.fetchStarRailRoleDetail(with: uid, roleID: roleID, roleRegion: roleRegion)
            .tryMap { (result: StarRailRoleInfoModel) in
                guard let data = result.data else {
                    return
                }
                SQLManagerHelper.saveStarRailRoleSkill(uid: uid, roleID: roleID, info: data)
            }
            .map { _ in }
            .replaceError(with: ())
            .eraseToAnyPublisher()
    }

    private func featchRoleCompute(
        uid: String, 
        roleRegion: String,
        role: StarRailRoleInfoData
    ) {
        let section = sections.first { $0.uid == uid }
        let filterRole = section?.roleList.first { $0.itemID == role.avatar?.itemID ?? "" }
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
