//
//  SideBarViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/5.
//

import Foundation

class SideBarViewModel: ObservableObject {
    @Published var sections: [SideBarSectionModel] = []

    func fetchSideBarSections() {

        let notes = [
            SideBarItemModel(
                name: CopySideBar.notesTitle,
                iconName: "list.bullet.clipboard.fill",
                type: .notes
            ),
            SideBarItemModel(
                name: CopySideBar.usersTitle,
                iconName: "person.circle.fill",
                type: .users
            )
        ]

        sections = [
            SideBarSectionModel(
                sectionName: "",
                sectionIcon: "",
                items: notes
            ),
            getStarRailSesction(),
            getGenshinImpactSesction()
        ]
    }

    func getStarRailSesction() -> SideBarSectionModel {
        let starRailItems = [
            SideBarItemModel(
                name: CopySideBar.starRailRole,
                iconName: IconSideBar.roleList.rawValue,
                type: .starRailRole
            ),
            SideBarItemModel(
                name: CopySideBar.starRailMap,
                iconName: IconSideBar.map.rawValue,
                type: .starRailMap
            ),
            SideBarItemModel(
                name: CopySideBar.starRailWiki,
                iconName: IconSideBar.wiki.rawValue,
                type: .starRailWiki
            )
        ]
        return SideBarSectionModel(
            sectionName: CopySideBar.starRailTitle,
            sectionIcon: IconSideBar.starRailSection.rawValue,
            items: starRailItems
        )
    }

    func getGenshinImpactSesction() -> SideBarSectionModel {
        let starRailItems = [
            SideBarItemModel(
                name: CopySideBar.genshinRole,
                iconName: IconSideBar.roleList.rawValue,
                type: .genshinImpactRole
            ),
            SideBarItemModel(
                name: CopySideBar.genshinMap,
                iconName: IconSideBar.map.rawValue,
                type: .genshinImpactMap
            ),
            SideBarItemModel(
                name: CopySideBar.genshinWiki,
                iconName: IconSideBar.wiki.rawValue,
                type: .genshinImpactWiki
            )
        ]
        return SideBarSectionModel(
            sectionName: CopySideBar.genshinTitle,
            sectionIcon: IconSideBar.starRailSection.rawValue,
            items: starRailItems
        )
    }
}
