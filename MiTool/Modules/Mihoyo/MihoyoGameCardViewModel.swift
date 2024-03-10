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
    @Published var gameRecord: [MihoyoGameCardsList] = []
    
    func getMihoyoGameCard(_ uid: String) {
        ApiManager.fetchMihoyoGameCards(uid: uid) { [weak self] gameList in
            self?.gameRecord = gameList
        }
    }
}
