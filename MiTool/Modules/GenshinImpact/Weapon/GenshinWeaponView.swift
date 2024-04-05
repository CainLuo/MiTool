//
//  GenshinWeaponView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import SwiftUI

struct GenshinWeaponView: View {
    @StateObject var viewModel = GenshinWeaponViewModel()
    @State private var isPopoverShowing = false
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 6
    )

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.list) { item in
                    NavigationLink {
                        GenshinWeaponComputeView(item: item)
                    } label: {
                        GenshinWeaponItemView(item: item)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .task {
            viewModel.fetchWeapons()
        }
    }
}

struct GenshinWeaponItemView: View {
    private let configuration = ViewConfiguration(frame: CGSize(width: 150, height: 150))
    private let star = ViewConfiguration(frame: CGSize(width: 150, height: 40))
    
    let item: GenshinWeaponItemModel
    
    var body: some View {
        VStack(spacing: 5) {
            ImageView(
                provider: .remote(item.iconURL),
                configuration: configuration
            )
            .background(
                item.weaponLevel.ratityColor
            )
            Text(item.nameContent)
            Text(item.levelContent)
            ImageView(
                provider: .local(item.weaponLevel.ratityImage),
                configuration: star
            )
        }
    }
}

#Preview {
    GenshinWeaponView()
        .frame(
            minWidth: 1000,
            maxWidth: .infinity,
            minHeight: 1000,
            maxHeight: .infinity
        )
}
