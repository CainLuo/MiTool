//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import SwiftUI

class MihoyoUserEditViewModel: ObservableObject {
    @Published var saveUserSuccess = false
    @Published var saveUserFailed = false

    func saveMihoyoUser(
        nickname: String,
        uid: String,
        cookie: String,
        sToken: String
    ) {
        SQLManager.shared.getMihoyoUser(uid) { [weak self] success, user in
            let userInfo = MihoyoUserInfo(uid: uid, nickname: nickname, cookie: cookie, sToken: sToken)
            if user == nil {
                self?.saveMihoyoUser(userInfo)
            } else {
                self?.upgradeMihoyoUser(userInfo)
            }
        }
    }
    
    private func saveMihoyoUser(_ userInfo: MihoyoUserInfo) {
        SQLManager.shared.addMihoyoUser(userInfo) { [weak self] success, error in
            guard error == nil else {
                self?.saveUserFailed = true
                return
            }
            self?.saveUserSuccess = success
        }
    }
    
    private func upgradeMihoyoUser(_ userInfo: MihoyoUserInfo) {
        SQLManager.shared.upgradeMihoyoUser(
            userInfo.uid,
            model: userInfo
        ) { [weak self] success, error in
            guard error == nil else {
                self?.saveUserFailed = true
                return
            }
            self?.saveUserSuccess = success
        }
    }
}
