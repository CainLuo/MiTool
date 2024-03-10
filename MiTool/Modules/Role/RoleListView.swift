//
//  RoleListView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import SwiftUIX

struct RoleListView: View {
    @StateObject var viewModel = RoleListViewModel()

    var body: some View {
        Section {
            List(viewModel.roleList) { item in
                RoleInfoView(id: item.itemID ?? "")
            }
        } header: {
            HStack {
                SectionHeaderView(
                    userName: viewModel.userName,
                    uid: viewModel.uid
                )
                
                Spacer()
            }
            .padding([.top, .leading])
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
