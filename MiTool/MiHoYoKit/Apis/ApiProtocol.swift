//
//  ApiProtocol.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation

public protocol ApiProtocol {
    // MARK: - Mihoyo User
    func getMihoyoUserInfo() -> MihoyoUserModel
    func getMihoyoGameCards() -> MihoyoGameCardsModel

    // MARK: - GenshinImpact
    func getGshinImpactWeight() -> GenshinDailyNodeModel
    func getGshinImpactDailyNote() -> GenshinDailyNodeModel
    func getGshinImpactCharacter() -> GenshinCharacterModel
    func getGshinImpactAvatarList() -> Any
    func getGshinImpactFilterList() -> Any
    func getGshinImpactAvatarSkill() -> Any
    func getGshinImpactCompute() -> Any
    func getGshinImpactSpiralAbyss() -> Any

    // MARK: - Honkai: StarRail
    func getStarRailWidget() async -> StarRailWeightModel?
    func getStarRailDailyNote() -> StarRailWeightModel
    func getStarRailCharacter() -> Any
    func getStarRailAvatarList() -> Any
    func getStarRailAvatarDetail() -> Any
    func getStarRailEquipmentList() -> Any
    func getSkillCompute(id: String) -> StarRailSkillComputeModel
    func getSkillRogue(id: String) -> Any
    func getSkillChallenge(id: String) -> Any

    func getStarRailMyRoleList() -> StarRailAllRoleModel
    func getRoleInfo(id: String) -> StarRailRoleInfoModel
}
