//
//  RoleInfoView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI
import Kingfisher

struct RoleInfoView: View {
    @StateObject var viewModel = RoleInfoViewModel()
    
    let id: String
    
    var body: some View {
        VStack {
            HStack {
                RoleInfoDrawingView(viewModel: viewModel)
                        
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        RoleInfoEquipment(viewModel: viewModel)

                        RoleInfoSkillsView(
                            skills: viewModel.skills,
                            talentSkills: viewModel.talentSkills,
                            otherSkills: viewModel.otherSkills
                        )
                    }
                    RoleInfoConsumeView(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.getRoleInfo(id: id)
        }
    }
}

struct RoleInfoEquipment: View {
    @StateObject var viewModel: RoleInfoViewModel

    var body: some View {
        VStack {
            Text(CopyStarRailRole.equipmentTitle)
                .boldModifier(size: 24)
                .padding(.top, 10)
            
            KFImage(URL(string: viewModel.equipment.itemURL ?? ""))
                .sizeFillModifier(width: 150, height: 150)
                .padding(0)
            
            Image(viewModel.equipment.rarity.ratityImage)
                .sizeModifier(width: 100, height: 30)
                .padding(0)
            
            Text(viewModel.equipment.itemName ?? "")
                .boldModifier(size: 24)

            Text(viewModel.equipment.levelString)
                .sizeModifier(size: 16)
                .padding(.bottom, 5)
        }
        .background(.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct RoleInfoSkillsView: View {
    let skills: [StarRailRoleInfoSkill]
    let talentSkills: [StarRailRoleInfoSkill]
    let otherSkills: [StarRailRoleInfoSkill]

    var body: some View {
        VStack {
            HStack {
                ForEach(skills) { skill in
                    VStack {
                        VStack {
                            KFImage(URL(string: skill.itemURL ?? ""))
                                .sizeModifier(width: 30, height: 30)
                            Text(skill.skillLevel)
                        }
                        .padding()
                        .background(.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            
            HStack {
                ForEach(talentSkills) { skill in
                    VStack {
                        KFImage(URL(string: skill.itemURL ?? ""))
                            .sizeModifier(width: 30, height: 30)
                    }
                    .padding(5)
                    .background(.black.opacity(0.5))
                    .clipShape(Circle())
                }
            }
            
            HStack {
                ForEach(otherSkills) { skill in
                    VStack {
                        KFImage(URL(string: skill.itemURL ?? ""))
                            .sizeModifier(width: 30, height: 30)
                    }
                    .padding(5)
                    .background(.black.opacity(0.5))
                    .clipShape(Circle())
                }
            }
        }
    }
}

struct RoleInfoDrawingView: View {
    @StateObject var viewModel = RoleInfoViewModel()

    var body: some View {
        VStack {
            Image(viewModel.avatar.itemID ?? "")
                .sizeFillModifier(width: 250, height: 600)
                .background(.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Image(viewModel.avatar.rarity.ratityImage)
                .sizeModifier(width: 200, height: 44)
            
            HStack {
                VStack(spacing: 8) {
                    Text(viewModel.avatar.itemName ?? "")
                        .boldModifier(size: 24)
                        .foregroundColor(.white)
                    Text(viewModel.avatar.level)
                        .sizeModifier(size: 16)
                }
                
                HStack {
                    Image(viewModel.avatar.avatarBaseType?.destinyIcon ?? "")
                        .sizeModifier(width: 35, height: 35)
                    Image(viewModel.avatar.damageType?.damagetIcon ?? "")
                        .sizeModifier(width: 25, height: 40)
                }
            }
        }
    }
}

struct RoleInfoConsumeView: View {
    @StateObject var viewModel: RoleInfoViewModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 10
    )

    var body: some View {
        if viewModel.consumeSections.isEmpty {
            Text(CopyStarRailRole.finishedConsume)
                .boldModifier(size: 24)
                .frame(width: 650, height: 200)
                .background(.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.consumeSections) { section in
                    Section(section.title) {
                        ForEach(section.consume) { item in
                            VStack {
                                StarRaillRarityView(
                                    rarity: item.rarity ?? .one,
                                    urlString: item.itemURL ?? ""
                                )
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Text("\(item.itemName ?? "")\n\(item.num ?? 0)")
                                    .frame(width: 100)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RoleInfoView(id: "1003")
        .frame(width: 1200, height: 800)
}
