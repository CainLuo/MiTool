//
//  BaseViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/22.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()

    init() {
        // 初始化ViewModel
    }

    deinit {
        cancelSubscriptions()
    }
    
    func cancelSubscriptions() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
