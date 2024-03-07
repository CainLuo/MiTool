//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/7.
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
