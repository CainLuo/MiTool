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
        guard let gameRecord = api.getMihoyoGameCards().data?.list,
              let gameCardJSON = gameRecord.toJSONString() else {
            return
        }
        
        language = Locale.autoupdatingCurrent.identifier
        
        self.gameRecord = gameRecord
        
        debugPrint(gameCardJSON)
        
//        manager.upgradeMihoyoUserGameCard(uid,
//                                          gameCardJSON: gameCardJSON) { success, error in
//            
//        }
    }
}
