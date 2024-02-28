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
    
    @Published var gameRecord: [MihoyoGameRecordList] = []
    @Published var language: String = ""

    func getMihoyoGameCard(_ uid: String) {
        guard let gameRecord = api.getMihoyoGameRecord().data?.list,
              let gameCardJSON = gameRecord.toJSONString() else {
            return
        }
        
        language = Locale.autoupdatingCurrent.identifier
        
        self.gameRecord = gameRecord
        
//        manager.upgradeMihoyoUserGameCard(uid,
//                                          gameCardJSON: gameCardJSON) { success, error in
//            
//        }
    }
}
