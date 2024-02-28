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
    
    var columns = Array(repeating: GridItem(.flexible()),
                        count: 8)
    
    var destiny = [Destiny.destruction, Destiny.theHunt,
                   Destiny.erudition, Destiny.harmony,
                   Destiny.nihility, Destiny.preservation,
                   Destiny.abundance]

    var body: some View {
        ScrollView {
            VStack {
                if !viewModel.roleList.isEmpty {
                    ForEach(destiny.indices, id: \.self) { section in
                        Section {
                            HStack {
                                Image("abundance")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 25)
                                
                                Text("毁灭")
    
                                Spacer()
                            }
                        }

                        LazyVGrid(columns: columns, spacing: 15, content: {
                            let list = viewModel.roleList.filter { $0.avatarBaseType == destiny[section] }
                            ForEach(list.indices, id: \.self) { index in
                                RoleCardView(item: list[index])
                            }
                        })
                        Divider()
                    }
                }
            }
        }
        .onAppear {
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
