//
//  GenshinWeaponComputeView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import SwiftUI

struct GenshinWeaponComputeView: View {
    @StateObject private var viewModel = GenshinWeaponViewModel()
    
    let item: GenshinWeaponItemModel
    
    @State private var currentLevel: String = "1"
    @State private var maxLevel: String = "90"
    
    private let configuration = ViewConfiguration(
        shape: .roundedRectangle(cornerRadius: 20),
        frame: CGSize(width: 250, height: 250)
    )
    private let starModify = ViewConfiguration(
        frame: CGSize(width: 200, height: 80)
    )
    private let consumeModify = ViewConfiguration(
        frame: CGSize(width: 60, height: 60)
    )
    @State private var isPopoverVisible = false

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 3
    )

    var body: some View {
        VStack {
            HStack {
                ImageView(
                    provider: .remote(item.iconURL),
                    configuration: configuration
                )
                .background(
                    item.weaponLevel.ratityColor
                )

                HStack(spacing: 10) {
                    VStack {
                        Text(item.nameContent)
                            .font(.system(size: 25, weight: .bold))
                        
                        ImageView(
                            provider: .local(item.weaponLevel.ratityImage),
                            configuration: starModify
                        )
                    }

                    HStack {
                        Button(action: {
                            isPopoverVisible.toggle()
                        }, label: {
                            Text(currentLevel)
                                .font(.system(size: 16))
                                .padding()
                                .frame(width: 100)
                                .applyViewModifiers(
                                    shape: .roundedRectangle(cornerRadius: 10),
                                    backgroundColor: .gray
                                )
                        })
                        .buttonStyle(.plain)
                        
                        Text("-")
                        
                        Button(action: {
                            isPopoverVisible.toggle()
                        }, label: {
                            Text(maxLevel)
                                .font(.system(size: 16))
                                .padding()
                                .frame(width: 100)
                                .applyViewModifiers(
                                    shape: .roundedRectangle(cornerRadius: 10),
                                    backgroundColor: .gray
                                )
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.computeList) { item in
                    HStack {
                        ImageView(
                            provider: .remote(item.icon),
                            configuration: consumeModify
                        )
                        Text(item.name)
                            .font(.system(size: 14, weight: .bold))
                        Text("x\(item.num)")
                            .font(.system(size: 14))
                    }
                }
            }
        }
        .task {
            viewModel.fetchWeaponCompute(
                weaponID: item.weaponID ?? 1,
                currentLevel: 1,
                targetLevel: 90
            )
        }
    }
}

#Preview {
    GenshinWeaponComputeView(
        item: GenshinWeaponItemModel(
        id: 12404, 
        name: "宗室大剑",
        icon: "https://act-webstatic.mihoyo.com/hk4e/e20200928calculate/item_icon_u69a1f/6233db36a735e50820ff121de9d0cbfa.png",
        weaponCatId: 11, 
        weaponLevel: 4,
        maxLevel: 90,
        computeInfo: ""
        )
    )
        .frame(
            minWidth: 1000,
            maxWidth: .infinity,
            minHeight: 1000,
            maxHeight: .infinity
        )
}
