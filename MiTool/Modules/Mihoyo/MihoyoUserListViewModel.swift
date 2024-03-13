//
//  MihoyoUserListViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import SwiftUI

class MihoyoUserListViewModel: ObservableObject {
    private let manager = SQLManager.shared
    
    @Published var userList: [MihoyoUserInfo] = []
    
    func getMihoyoUserList() {
        userList = manager.getMihoyoUserList()
    }
}
