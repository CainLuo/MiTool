//
//  StarRailRoleInfoView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI
import Kingfisher

struct StarRailRoleInfoView: View {
    @StateObject var viewModel = StarRailRoleInfoViewModel()
    
    let id: String
    
    var body: some View {
        HStack {
            RoleInfoDrawingView(viewModel: viewModel)
                .padding([.top, .bottom], 10)
            RoleInfoConsumeView(viewModel: viewModel)
        }
        .padding([.leading, .trailing])
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .task {
            viewModel.getRoleInfo(id: id)
        }
    }
}

struct RoleInfoDrawingView: View {
    @StateObject var viewModel = StarRailRoleInfoViewModel()

    var body: some View {
        VStack {
            StarRaillRarityView(
                rarity: viewModel.avatar.rarity,
                urlString: viewModel.avatar.iconURL ?? ""
            )
            .frame(width: 120)
            
            Text(viewModel.avatar.itemName ?? "")
                .boldModifier(size: 26)
                .foregroundColor(.white)
            Text(viewModel.avatar.level)
                .sizeModifier(size: 20)
        }
    }
}

struct RoleInfoConsumeView: View {
    @StateObject var viewModel: StarRailRoleInfoViewModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 6
    )

    var body: some View {
        if viewModel.consumeSections.isEmpty {
            Text(CopyStarRailRole.finishedConsume)
                .boldModifier(size: 24)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        } else {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.consumeSections) { section in
                    Section {
                        ForEach(section.consume) { item in
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
                        HStack {
                            Text(section.title)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
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
    StarRailRoleInfoView(id: "1112")
        .frame(width: 800, height: 400)
}
