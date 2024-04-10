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
                ForEach(section.items) { item in
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
    let item: StarRailRoleSectionItemModel
        
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
    let item: StarRailRoleSectionItemModel

    var body: some View {
        VStack {
            StarRaillRarityView(
                rarity: item.roleItem.rarity,
                urlString: item.roleItem.iconURL ?? ""
            )
            .frame(width: 120)
            
            Text(item.roleItem.itemName ?? "")
                .boldModifier(size: 26)
                .foregroundColor(.white)
            Text(item.roleItem.level)
                .sizeModifier(size: 20)
        }
    }
}

struct RoleInfoConsumeView: View {
    let item: StarRailRoleSectionItemModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 6
    )

    var body: some View {
        if item.compute?.avatarConsume?.isEmpty == true &&
            item.compute?.skillConsume?.isEmpty == true &&
            item.compute?.equipmentConsume?.isEmpty == true {
            Text(CopyStarRailRole.finishedConsume)
                .boldModifier(size: 24)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        } else {
            LazyVGrid(columns: columns, alignment: .leading) {
                if let consume = item.compute?.avatarConsume,
                    consume.isNotEmpty {
                    Section {
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
                    } header: {
                        Text(CopyStarRailRole.avatarConsume)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                
                if let consume = item.compute?.skillConsume,
                   consume.isNotEmpty {
                    Section {
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
                    } header: {
                        Text(CopyStarRailRole.skillsConsume)
                            .font(.system(size: 16, weight: .bold))
                    }
                }
                
                if let consume = item.compute?.equipmentConsume,
                   consume.isNotEmpty {
                    Section {
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
                    } header: {
                        Text(CopyStarRailRole.equipmentConsume)
                            .font(.system(size: 16, weight: .bold))
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
