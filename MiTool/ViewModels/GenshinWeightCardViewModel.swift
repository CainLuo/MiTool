//
//  GenshinWeightCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI

class GenshinWeightCardViewModel: ObservableObject {
    private let manager = MockApi.shared
    
    @Published var data: GenshinImpactDailyNodeData = GenshinImpactDailyNodeData()
    @Published var recoveryTime: String = ""
    @Published var staminaColor: Color = .red
    
    func getGenshinWeight() {
        guard let data = manager.getGshinImpactWeight().data else {
            return
        }
        
        self.data = data
        let time = Int(data.resinRecoveryTime) ?? 0
        setUpRecoveryTime(staminaRecoverTime: time)
        setUpStaminaColor(staminaRecoverTime: time)
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
    
    private func setUpStaminaColor(staminaRecoverTime: Int) {
        let staminaLastTime = 1 - (CGFloat(staminaRecoverTime) / 86400.0)

        if staminaLastTime > 0.3 && staminaLastTime < 0.8 {
            staminaColor = .blue
        } else if staminaLastTime > 0.8 && staminaLastTime <= 1 {
            staminaColor = .green
        } else {
            staminaColor = .red
        }
    }
}
