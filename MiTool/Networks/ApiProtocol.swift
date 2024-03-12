//
//  ApiProtocol.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import Alamofire
import CryptoSwift

protocol ApiProtocol {
    // MARK: - Mihoyo User
    func getMihoyoUserInfo() -> MihoyoUserModel
    func getMihoyoGameCards() -> MihoyoGameCardsModel

    // MARK: - GenshinImpact
    func getGshinImpactWeight() -> GenshinImpactDailyNodeModel
    func getGshinImpactDailyNote() -> GenshinImpactDailyNodeModel
    func getGshinImpactCharacter() -> GenshinImpactCharacterModel
    func getGshinImpactAvatarList() -> Any
    func getGshinImpactFilterList() -> Any
    func getGshinImpactAvatarSkill() -> Any
    func getGshinImpactCompute() -> Any
    func getGshinImpactSpiralAbyss() -> Any

    // MARK: - Honkai: StarRail
    func getStarRailWidget() -> StarRailWidgetModel
    func getStarRailDailyNote() -> StarRailWidgetModel
    func getStarRailCharacter() -> Any
    func getStarRailAvatarList() -> Any
    func getStarRailAvatarDetail() -> Any
    func getStarRailEquipmentList() -> Any
    func getSkillCompute(id: String) -> StarRailSkillComputeModel
    func getSkillRogue(id: String) -> Any
    func getSkillChallenge(id: String) -> Any

    func getStarRailAllRoleList() -> StarRailAllRoleModel
    func getRoleInfo(id: String) -> StarRailRoleInfoModel
}
