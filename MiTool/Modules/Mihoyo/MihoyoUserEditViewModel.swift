//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import SwiftUI

class MihoyoUserEditViewModel: ObservableObject {
    @Published var saveUserSuccess = false

    func saveMihoyoUser(
        nickname: String,
        uid: String,
        cookie: String
    ) {
    }
}
