//
//  StarRailWeightCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

class StarRailWeightCardViewModel: ObservableObject {
    private let manager = MockApi.shared
        
    /// 0~0.3 is Color.red
    /// 0.3~0.8 is Color.blue
    /// 0.8~1 is Color.green
    @Published var staminaColor: Color = .red
    @Published var stamina: String = "0/0"
    @Published var staminaLastTime: CGFloat = 0
    @Published var expeditions: [StarRailWeightExpeditionModel] = []
    @Published var localModels: [StarRailLocalModel] = []
    @Published var recoveryTime: String = ""
    @Published var reserveStamina: String = ""
    @Published var reserveStaminaFull: String = ""

    func getStarRailWeight() {        
        let model = manager.getStarRailWeight()
        
        guard let data = model.data else {
            return
        }
        
        expeditions = data.expeditions ?? []
        stamina = "\(data.currentStamina)/\(data.maxStamina)"
        reserveStamina = CopyStarRailWeight.reserveTrailblazePower + "\(data.currentReserveStamina)"
        let tipsString = "\(data.isReserveStaminaFull ? CopyStarRailWeight.fullYes : CopyStarRailWeight.fullNo)"
        reserveStaminaFull = CopyStarRailWeight.reserveTrailblazePowerFull + tipsString
        
        setUpStaminaColor(staminaRecoverTime: data.staminaRecoverTime)
        setUpLocalModels(data: data)
    }
    
    private func setUpStaminaColor(staminaRecoverTime: Int) {
        setUpRecoveryTime(staminaRecoverTime: staminaRecoverTime)
        let staminaLastTime = 1 - (CGFloat(staminaRecoverTime) / 86400.0)
        self.staminaLastTime = staminaLastTime

        if staminaLastTime > 0.3 && staminaLastTime < 0.8 {
            staminaColor = .blue
        } else if staminaLastTime > 0.8 && staminaLastTime <= 1 {
            staminaColor = .green
        } else {
            staminaColor = .red
        }
    }
    
    private func setUpLocalModels(data: StarRailWeightDataModel) {
        localModels = [
            StarRailLocalModel(
                type: .daily,
                currentValue: data.currentTrainScore,
                maxValue: data.maxTrainScore
            ),
            StarRailLocalModel(
                type: .weekly,
                currentValue: data.currentRogueScore,
                maxValue: data.maxRogueScore
            ),
            StarRailLocalModel(
                type: .entrusted,
                currentValue: data.acceptedEpeditionNum,
                maxValue: data.totalExpeditionNum
            ),
            StarRailLocalModel(
                type: .weeklyMonster,
                currentValue: data.weeklyCocoonCnt,
                maxValue: data.weeklyCocoonLimit
            )
        ]
    }
    
    private func setUpRecoveryTime(staminaRecoverTime: Int) {
        if staminaRecoverTime == 0 {
            recoveryTime = "已恢复"
        } else if staminaRecoverTime < 3600 {
            let minutes = staminaRecoverTime / 60
            recoveryTime = "0小时\(minutes)分钟"
        } else {
            let minutes = staminaRecoverTime % 3600 / 60
            let hour = Int(staminaRecoverTime / 3600)
            recoveryTime = "\(hour)小时\(minutes)分钟"
        }
    }
}
