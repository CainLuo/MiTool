//
//  MihoyoUserManager.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import SwiftUI

struct MihoyoUser: Identifiable {
    var id = UUID()
    var cookie: String?
    var accountUID: String?
    var gameUID: String?
    var region: Region
    var sToken: String?
    
    init(
        cookie: String?,
        accountUID: String?,
        gameUID: String?,
        region: Region = .china,
        sToken: String?
    ) {
        self.cookie = cookie
        self.accountUID = accountUID
        self.gameUID = gameUID
        self.region = region
        self.sToken = sToken
    }
}

class MihoyoUserManager {
    static let shared = MihoyoUserManager()
    
    private init() {
        // Initialize and fetch user information when the singleton is created
        fetchUserInformation()
    }
    
    @Published var users: [MihoyoUser] = []
    
    func fetchUserInformation() {
        let userList = SQLManager.shared.getMihoyoUserList()
        let gameList = userList.map { SQLManager.shared.getAllMihoyoGameCards(uuid: $0.uid) }
                
        users = SQLManager.shared.getMihoyoUserList()
            .map {
                MihoyoUser(
                    cookie: $0.cookie, 
                    accountUID: $0.uid,
                    gameUID: "",
                    region: Region(rawValue: $0.region ?? "") ?? .china,
                    sToken: $0.sToken
                )
            }
    }
    
    func addUser(userInfo: MihoyoUserInfo) {
        let user = MihoyoUser(
            cookie: userInfo.cookie,
            accountUID: userInfo.uid,
            gameUID: "",
            region: Region(rawValue: userInfo.region ?? "") ?? .china,
            sToken: userInfo.sToken
        )

        users.append(user)
    }
    
    func getUserInfo(uid: String, isAccountUID: Bool) -> MihoyoUser? {
        if isAccountUID {
            return users.first { $0.accountUID == uid }
        } else {
            return users.first { $0.gameUID == uid }
        }
    }
}
