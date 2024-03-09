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
    var genshinUID: String
    var starRailUID: String
    
    var uidString: String {
        "UID: \(uid)"
    }
}
