//
//  SideBarModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/5.
//

import Foundation

enum SideBarType {
    case notes
    case users

    case starRailRole
    case starRailMap
    case starRailWiki
    
    case genshinImpactRole
    case genshinImpactMap
    case genshinImpactWiki
}

struct SideBarSectionModel: Identifiable, Hashable {
    var id = UUID()
    var sectionName: String
    var sectionIcon: String
    var items: [SideBarItemModel]
}

struct SideBarItemModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var iconName: String
    var type: SideBarType
}

struct SideBarHeaderModel: Identifiable, Hashable {
    var id = UUID()
    var iconName: String
    var userName: String
    var iconUrlString: String?

    var iconURL: URL? {
        guard let iconUrlString = iconUrlString else {
            return nil
        }
        return URL(string: iconUrlString)
    }
}
