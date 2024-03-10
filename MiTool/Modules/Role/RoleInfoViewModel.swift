//
//  RoleInfoViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI

class RoleInfoViewModel: ObservableObject {
    let api = MockApi.shared
    
    @Published var avatar = StarRailRoleInfoAvatar()
    @Published var skills: [StarRailRoleInfoSkill] = []
    @Published var talentSkills: [StarRailRoleInfoSkill] = []
    @Published var otherSkills: [StarRailRoleInfoSkill] = []
    @Published var equipment = StarRailRoleInfoEquipment()
        
    @Published var consumeSections: [StarRailLocalCompute] = []

    func getRoleInfo(id: String) {
        let model = api.getRoleInfo(id: id)
        
        guard let data = model.data else {
            return
        }
                
        if let avatar = data.avatar {
            self.avatar = avatar
        }
        
        if let equipment = data.equipment {
            self.equipment = equipment
        }
        
        self.skills = data.skills
        self.talentSkills = data.skillsOther.filter {
            $0.pointType != .other &&
            $0.progress == .learned
        }
        self.otherSkills = data.skillsOther.filter {
            $0.pointType == .other &&
            $0.progress == .learned
        }
        
        getRoleSkilCoupute(id: id)
    }
    
    private func getRoleSkilCoupute(id: String) {
        let model = api.getSkillCompute(id: id)
        
        guard let data = model.data else {
            return
        }
        
        var consumeSections: [StarRailLocalCompute] = []
        
        if let consume = data.avatarConsume,
            !consume.isEmpty {
            let compute = StarRailLocalCompute(
                title: CopyStarRailRole.avatarConsume,
                consume: consume
            )
            consumeSections.append(compute)
        }
        
        if let consume = data.skillConsume,
           !consume.isEmpty {
            let compute = StarRailLocalCompute(
                title: CopyStarRailRole.skillsConsume,
                consume: consume
            )
            consumeSections.append(compute)
        }
        
        if let consume = data.equipmentConsume,
           !consume.isEmpty {
            let compute = StarRailLocalCompute(
                title: CopyStarRailRole.equipmentConsume,
                consume: consume
            )
            consumeSections.append(compute)
        }
        self.consumeSections = consumeSections
    }
}
