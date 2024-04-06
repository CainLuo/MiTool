//
//  StarRailRoleListViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI

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
        SQLManager.shared.getGenshinGameCard(uuid: uid) { item in
            section.userName = item.nickname
            section.uid = item.gameUID
            section.server = item.region
        }

        let locaList = SQLManager.shared.getAllStarRailRoleList(uuid: uid)
        section.roleList = locaList.sorted { left, right in
            left.rarity.rawValue > right.rarity.rawValue
        }
        
        if locaList.isEmpty {
            ApiManager.shared.featchStarRailRoleList(with: section.uid, server: section.server, page: 1)
                .sink { (result: StarRailAllRoleModel) in
                    guard let list = result.data?.list else {
                        return
                    }
                    section.roleList = list
                    SQLManagerHelper.saveStarRailRoleDetail(uid: section.uid, list: list)
                }
                .store(in: &cancellables)
        }
        
        sections.append(section)
        
        for role in section.roleList {
            fetchRoleDetail(uid: section.uid, roleID: role.itemID ?? "")
        }
    }
    
    private func fetchRoleDetail(uid: String, roleID: String) {
        let section = sections.first { $0.uid == uid }
        let role = section?.roleList.first { $0.itemID == roleID }
        guard var role else {
            return
        }
        
        ApiManager.shared.fetchStarRailRoleDetail(with: uid, roleID: roleID)
            .sink { [weak self] (result: StarRailRoleInfoModel) in
                guard let data = result.data else {
                    return
                }
                SQLManagerHelper.saveStarRailRoleSkill(uid: uid, roleID: roleID, info: data)
                role.roleInfo = data
                self?.featchRoleCompute(uid: uid, server: section?.server ?? "", role: data)
            }
            .store(in: &cancellables)
    }
    
    private func featchRoleCompute(uid: String, server: String, role: StarRailRoleInfoData) {
        let skillList = filterSkills(role: role)
        var json: [String: Any] = [
            "game": "hkrpg",
            "lang": "zh-cn",
            "uid": uid,
            "region": server,
            "avatar": [
                "item_id": role.avatar?.itemID ?? "",
                "cur_level": role.avatar?.curLevel ?? 1,
                "target_level": role.avatar?.targetLevel ?? 80
            ],
            "equipment": [],
            "skill_list": skillList
        ]
        
        if let eqiopment = role.equipment {
            json["equipment"] = [
                "item_id": eqiopment.itemID ?? "",
                "cur_level": eqiopment.curLevel,
                "target_level": eqiopment.targetLevel
            ]
        }
        
        let request = StarRailRoleComputeRequestModel(JSON: json)
        guard let request else {
            return
        }
        
        let section = sections.first { $0.uid == uid }
        let filterRole = section?.roleList.first { $0.itemID == role.avatar?.itemID ?? "" }
        guard var filterRole else {
            return
        }

        ApiManager.shared.fetchStarRailRoleSkillCompute(with: request)
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

    private func filterSkills(role: StarRailRoleInfoData) -> [[String: Any]] {
        var requestSkills: [[String: Any]] = []
        var roleSkills: [StarRailRoleInfoSkill] = []
        let point1Skill = role.skills.filter { $0.anchor == .one && $0.curLevel < 6 }
        let pointSkills = role.skills.filter { $0.anchor != .one && $0.curLevel < 10 }
        
        roleSkills.append(contentsOf: point1Skill)
        roleSkills.append(contentsOf: pointSkills)
        
        if roleSkills.isNotEmpty {
            requestSkills = roleSkills.map {
                [
                    "item_id": $0.pointID ?? "",
                    "cur_level": $0.curLevel,
                    "target_level": $0.maxLevel ?? 1
                ]
            }
        }
        
        let skillsOther = role.skillsOther.filter { $0.progress != .learned }
            .map {
                [
                    "item_id": $0.pointID ?? "",
                    "cur_level": $0.curLevel,
                    "target_level": $0.maxLevel ?? 1
                ]
            }
        
        if skillsOther.isNotEmpty {
            requestSkills.append(contentsOf: skillsOther)
        }
        
        return requestSkills
    }
}
