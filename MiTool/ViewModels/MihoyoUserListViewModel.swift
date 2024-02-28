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

/**
stuid=182692936;stoken=v2_EZ6JDJqFF8b9dh5I5f1h5YHWd3Pxoae1Pmj8_daxDl1OFymHN9qOpsNrHZKfiTTyumOOS7suqEftRLeC-VhWTZHaaJveWlx6iZlLURFodFQn1t-tr2TUmYSlV_-tUsA=;mid=0otk3b2k90_mhy;login_ticket=dqY0SCsvLuYnuPwmjIYewsgpcCTVltR4IgOu9GGK;
 */
