//
//  ContentView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/1/30.
//

import SwiftUI

struct ContentView: View {
    @State var selection: SideBarType = .notes

    var body: some View {
        NavigationSplitView {
            SideBar(selection: $selection)
        } detail: {
            switch selection {
            case .notes:
                WidgetView()
            case .users:
                MihoyoUserListView()
            case .starRailRole:
                RoleListView()
//                RoleInfoView(id: "1003")
            case .starRailWiki:
                WiKiMap(selection: $selection)
            case .starRailMap:
                WiKiMap(selection: $selection)
            case .genshinImpactRole:
                EmptyView()
            case .genshinImpactMap:
                WiKiMap(selection: $selection)
            case .genshinImpactWiki:
                WiKiMap(selection: $selection)
            }
        }
    }
}

#Preview {
    ContentView(selection: .notes)
        .frame(width: 1200, height: 1000)
}
