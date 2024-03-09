//
//  RoleListView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import SwiftUIX

struct RoleListView: View {
    @StateObject var viewModel = RoleAllViewModel()
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 8
    )
    
    var destiny = [
        Destiny.destruction, Destiny.theHunt,
        Destiny.erudition, Destiny.harmony,
        Destiny.nihility, Destiny.preservation,
        Destiny.abundance
    ]

    var body: some View {
        List(viewModel.roleList) { item in
            RoleInfoView(id: item.itemID ?? "")
        }
        .task {
            viewModel.fetchRoleAllList()
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    }
}

#Preview {
    RoleListView()
}
