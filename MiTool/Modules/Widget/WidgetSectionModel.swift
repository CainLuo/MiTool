//
//  WidgetSectionModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/2.
//

import Foundation

struct WidgetSectionModel: Identifiable {
    var id = UUID()
    var uid: String
    var title: String
    var genshinItem: WidgetSectionItem
    var starRailItem: WidgetSectionItem
    
    var uidString: String {
        "UID: \(uid)"
    }
}

struct WidgetSectionItem: Identifiable {
    var id = UUID()
    var uid: String = ""
    var nickname: String = ""
    var server: String = ""
    
    var uidString: String {
        "UID: \(uid)"
    }
    
    var nicknameString: String {
        String(format: CopyGameName.nickname, nickname)
    }
    
    init() { }
    
    init(uid: String, nickname: String, server: String) {
        self.uid = uid
        self.nickname = nickname
        self.server = server
    }
}
