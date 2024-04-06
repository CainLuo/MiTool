//
//  StarRailRoleListView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import SwiftUIX

struct StarRailRoleListView: View {
    @StateObject var viewModel = StarRailRoleListViewModel()

    var body: some View {
        List(viewModel.sections) { section in
            Section {
                ForEach(section.roleList) { item in
                    StarRailRoleInfoView(
                        uid: section.uid,
                        item: item, 
                        viewModel: viewModel
                    )
                }
            } header: {
                HStack {
                    SectionHeaderView(
                        userName: section.userName,
                        uid: section.uid
                    )
                    
                    Spacer()
                }
                .padding()
            }
        }
        .task {
            viewModel.fetchRoleAllList()
        }
    }
}

struct StarRailRoleInfoView: View {
    let uid: String
    let item: StarRailAllRoleListModel
        
    @StateObject var viewModel: StarRailRoleListViewModel

    var body: some View {
        HStack {
            RoleInfoDrawingView(item: item)
                .padding([.top, .bottom], 10)
            RoleInfoConsumeView(item: item)
        }
        .padding([.leading, .trailing])
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
    }
}

struct RoleInfoDrawingView: View {
    let item: StarRailAllRoleListModel

    var body: some View {
        VStack {
            StarRaillRarityView(
                rarity: item.rarity,
                urlString: item.iconURL ?? ""
            )
            .frame(width: 120)
            
            Text(item.itemName ?? "")
                .boldModifier(size: 26)
                .foregroundColor(.white)
            Text(item.level)
                .sizeModifier(size: 20)
        }
    }
}

struct RoleInfoConsumeView: View {
    let item: StarRailAllRoleListModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 6
    )

    var body: some View {
        if item.compute == nil {
            Text(CopyStarRailRole.finishedConsume)
                .boldModifier(size: 24)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        } else {
            LazyVGrid(columns: columns) {
                if let consume = item.compute?.avatarConsume {
                    ForEach(consume) { item in
                        HStack {
                            StarRaillRarityView(
                                rarity: item.rarity ?? .one,
                                urlString: item.itemURL ?? ""
                            )
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(item.itemName ?? "")")
                                Text("\(item.num ?? 0)")
                            }
                        }
                    }
                }
                
                if let consume = item.compute?.skillConsume {
                    ForEach(consume) { item in
                        HStack {
                            StarRaillRarityView(
                                rarity: item.rarity ?? .one,
                                urlString: item.itemURL ?? ""
                            )
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(item.itemName ?? "")")
                                Text("\(item.num ?? 0)")
                            }
                        }
                    }
                }
                
                if let consume = item.compute?.equipmentConsume {
                    ForEach(consume) { item in
                        HStack {
                            StarRaillRarityView(
                                rarity: item.rarity ?? .one,
                                urlString: item.itemURL ?? ""
                            )
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(item.itemName ?? "")")
                                Text("\(item.num ?? 0)")
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 650, maxWidth: .infinity)
            .padding()
        }
    }
}

#Preview {
    StarRailRoleListView()
        .frame(
            minWidth: 1000, 
            maxWidth: .infinity,
            minHeight: 1000, 
            maxHeight: .infinity
        )
}
