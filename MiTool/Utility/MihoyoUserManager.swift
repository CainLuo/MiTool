//
//  MihoyoUserManager.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import SwiftUI

class MihoyoUserManager {
    static let shared = MihoyoUserManager()
    
    private init() {
        // Initialize and fetch user information when the singleton is created
        fetchUserInformation()
    }
    
    var users: [MihoyoUserInfo] = []
    var gameUser: [MihoyoGameCardsList] = []

    func fetchUserInformation() {
        users = SQLManager.shared.getMihoyoUserList()
//        users.forEach {
//            gameUser.append(contentsOf: SQLManager.shared.getAllMihoyoGameCards(uuid: $0.uid))
//        }
    }
    
    func addUser(userInfo: MihoyoUserInfo) {
        
    }
    
    func getUserInfo(uid: String) -> MihoyoUserInfo? {
        users.first { $0.uid == uid }
    }
    
    func getGameUserInfo(uid: String) -> MihoyoGameCardsList? {
        gameUser.first { $0.gameUID == uid }
    }
}
