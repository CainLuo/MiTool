//
//  MihoyoUserListViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import SwiftUI

class MihoyoUserListViewModel: ObservableObject {
    private let api = MockApi.shared
    private let manager = SQLManager.shared
    
    @Published var userList: [MihoyoUserListModel] = []
    @Published var saveUserSuccess = false
    
    func getMihoyoUserList() {
        userList = manager.getMihoyoUserList()
    }
    
    func saveMihoyoUser(
        nickname: String,
        uid: String,
        cookie: String
    ) {
        let user = MihoyoUserInfo(
            nickname: nickname,
            uid: uid,
            cookie: cookie
        )

        let userInfo = api.getMihoyoUserInfo()
        
        guard let uid = userInfo.data?.userInfo?.uid else {
            return
        }
        
        if manager.getMihoyoUserList().isEmpty {
            manager.addMihoyoUser(user) { success, error in
                guard success else {
                    debugPrint("Save failed: \(error?.localizedDescription ?? "")")
                    return
                }
                self.saveUserSuccess = success
                self.getMihoyoUserList()
            }
        } else {
            manager.upgradeMihoyoUser(uuid: uid, user) { success, error in
                guard success else {
                    debugPrint("Upgrade failed: \(error?.localizedDescription ?? "")")
                    return
                }
                self.saveUserSuccess = success
                self.getMihoyoUserList()
            }
        }
        saveMihoyoGameCards(uid: uid)
    }
    
    func saveMihoyoGameCards(uid: String) {
        let gameCards = api.getMihoyoGameCards()

        guard let gameCards = gameCards.data?.list else {
            return
        }
        
        if manager.getAllMihoyoGameCards(uuid: uid).isEmpty {
            manager.addMihoyoGameCards(
                uuid: uid,
                model: gameCards
            ) { success, error in
                guard success else {
                    debugPrint("Save failed: \(error?.localizedDescription ?? "")")
                    return
                }
                debugPrint("Save mihoyo game cards success")
            }
        } else {
            manager.upgradeMihoyoGameCards(
                uuid: uid,
                model: gameCards
            ) { success, error in
                guard success else {
                    debugPrint("Upgrade failed: \(error?.localizedDescription ?? "")")
                    return
                }
                debugPrint("Upgrade mihoyo game cards success")
            }
        }
    }
}
