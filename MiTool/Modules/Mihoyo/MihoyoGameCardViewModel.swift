//
//  MihoyoGameCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/18.
//

import SwiftUI
import ObjectMapper

class MihoyoGameCardViewModel: BaseViewModel {
    @Published var gameRecord: [MihoyoGameCardsList] = []
    
    func getMihoyoGameCard(_ uid: String) {
        ApiManager.shared.fetchMihoyoGameCards(uid: uid)
            .sink { [weak self] (result: MihoyoGameCardsModel) in
                guard let gameList = result.data?.list else {
                    return
                }
                self?.gameRecord = gameList
            }
            .store(in: &cancellables)
    }
}
