//
//  MihoyoGameCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/18.
//

import Foundation
import SwiftUI
import ObjectMapper

class MihoyoGameCardViewModel: ObservableObject {
    private let api = MockApi.shared
    private let manager = SQLManager.shared
    
    @Published var gameRecord: [MihoyoGameCardsList] = []
    @Published var language: String = ""
    
    func getMihoyoGameCard(_ uid: String) {
        let gameCards = api.getMihoyoGameCards()

        guard let gameCards = gameCards.data?.list else {
            return
        }
        
        manager.upgradeMihoyoGameCards(
            uuid: uid,
            model: gameCards
        ) { [weak self] success, error in
            guard success else {
                debugPrint("Upgrade failed: \(error?.localizedDescription ?? "")")
                return
            }
            debugPrint("Upgrade mihoyo game cards success")
            self?.gameRecord = gameCards
        }
    }
}
