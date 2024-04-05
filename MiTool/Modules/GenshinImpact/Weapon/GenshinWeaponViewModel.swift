//
//  GenshinWeaponViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import Foundation
import SwiftUI
import Combine

class GenshinWeaponViewModel: BaseViewModel {
    @Published var list: [GenshinWeaponItemModel] = []
    @Published var computeList: [GenshinWeaponComputeItemModel] = []

    private var page: Int = 1
    
    func getWeapons() {
        
    }
    
    func fetchWeapons() {
        ApiManager.shared.fetchGensinWeaponList(page: page)
            .sink { [weak self] (result: GenshinWeaponModel) in
                guard let list = result.data?.list,
                      list.isNotEmpty else {
                    return
                }
                self?.list.append(contentsOf: list)
                self?.page += 1
                self?.fetchWeapons()
            }
            .store(in: &cancellables)
    }
    
    func fetchWeaponCompute(
        weaponID: Int,
        currentLevel: Int,
        targetLevel: Int
    ) {
        ApiManager.shared.fetchGensinWeaponCompute(
            weaponID: weaponID,
            currentLevel: currentLevel,
            targetLevel: targetLevel
        )
        .sink { (result: GenshinWeaponComputeModel) in
            guard let list = result.data?.weaponConsume else {
                return
            }
            self.computeList = list
        }
        .store(in: &cancellables)
    }
}
