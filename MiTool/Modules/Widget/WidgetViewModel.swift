//
//  WidgetViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/2.
//

import SwiftUI

class WidgetViewModel: ObservableObject {
    @Published var widgetSections: [WidgetSectionModel] = []
    
    private let dbManager = SQLManager.shared
    
    func getWidgetSections() {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.character.rawValue
        ApiNetworkManager().getRequest(url: URL(string: url)!)
        
        let userList = dbManager.getMihoyoUserList()
        
        _ = userList.map { $0.uid }
    }
}
