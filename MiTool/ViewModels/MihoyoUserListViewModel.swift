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
    @Published var saveUserSuccess: Bool = false
    
    func getMihoyoUserList() {
        userList = manager.getMihoyoUserList()
    }
    
    func saveMihoyoUser(nickname: String,
                        uid: String,
                        cookie: String) {
        let user = MihoyoUserInfo(nickname: nickname,
                                  uid: uid,
                                  cookie: cookie)
        
        manager.addMihoyoUser(user) { success, error in
            guard success else {
                print("save failed: \(error?.localizedDescription ?? "")")
                return
            }
            self.saveUserSuccess = success
            self.getMihoyoUserList()
        }
    }
}
