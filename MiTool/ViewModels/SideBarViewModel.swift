//
//  SideBarViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/5.
//

import Foundation

class SideBarViewModel: ObservableObject {
    @Published var sections: [SideBarSectionModel] = []
    @Published var header = SideBarHeaderModel(iconName: IconSideBar.header,
                                               userName: "username")
    
    func fetchSideBarHeader() {
        header = SideBarHeaderModel(iconName: IconSideBar.header,
                                    userName: "凹凸曼的小怪兽",
                                    iconUrlString: "https://img1.baidu.com/it/u=996166138,4031649162&fm=253&fmt=auto&app=138&f=JPEG?w=360&h=360")
    }
    
    func fetchSideBarSections() {
        let starRailItems = [
            SideBarItemModel(name: CopySideBar.starRailRole,
                             iconName: IconSideBar.roleList,
                             type: .starRailRole),
            SideBarItemModel(name: CopySideBar.starRailMap,
                             iconName: IconSideBar.map,
                             type: .starRailMap),
            SideBarItemModel(name: CopySideBar.starRailWiki,
                             iconName: IconSideBar.wiki,
                             type: .starRailWiki)
        ]
        
        let notes = [
            SideBarItemModel(name: CopySideBar.notesTitle,
                             iconName: "list.bullet.clipboard.fill",
                             type: .notes),
            SideBarItemModel(name: CopySideBar.usersTitle,
                             iconName: "person.circle.fill",
                             type: .users)
        ]
        
        sections = [
            SideBarSectionModel(sectionName: "",
                                sectionIcon: "",
                                items: notes),
            SideBarSectionModel(sectionName: CopySideBar.starRailTitle,
                                sectionIcon: IconSideBar.starRailSection,
                                items: starRailItems)
        ]
    }
}
