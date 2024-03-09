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
                
                if viewModel.equipment.itemID != nil {
                    RoleInfoEquipment(viewModel: viewModel)
                }
                
                RoleInfoSkillsView(
                    skills: viewModel.skills,
                    talentSkills: viewModel.talentSkills,
                    otherSkills: viewModel.otherSkills
                )
                
                RoleInfoSkillsComputeView(viewModel: viewModel)
            }
            RoleInfoConsumeView(viewModel: viewModel)
        }
        .padding()
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .task {
            viewModel.getRoleInfo(id: id)
        }
    }
}

struct RoleInfoEquipment: View {
    @StateObject var viewModel: RoleInfoViewModel

    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.equipment.itemURL ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
    
            VStack {  
                Text(viewModel.equipment.itemName ?? "")
                    .boldModifier(size: 14)
                
                HStack {
                    Text(viewModel.equipment.levelString)
                        .sizeModifier(size: 14)
                    Text("叠影1")
                }
            }
        }
    }
}

struct RoleInfoSkillsView: View {
    let skills: [StarRailRoleInfoSkill]
    let talentSkills: [StarRailRoleInfoSkill]
    let otherSkills: [StarRailRoleInfoSkill]

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 5
    )

    var body: some View {
        VStack {
            HStack {
                ForEach(skills) { skill in
                    VStack {
                        KFImage(URL(string: skill.itemURL ?? ""))
                            .sizeModifier(width: 30, height: 30)
                        Text(skill.skillLevel)
                    }
                }
            }
            
            HStack {
                ForEach(talentSkills) { skill in
                    KFImage(URL(string: skill.itemURL ?? ""))
                        .sizeModifier(width: 30, height: 30)
                }
            }
            
            HStack {
                LazyVGrid(columns: columns) {
                    ForEach(otherSkills) { skill in
                        KFImage(URL(string: skill.itemURL ?? ""))
                            .sizeModifier(width: 30, height: 30)
                    }
                }
            }.frame(maxWidth: 300)
        }
    }
}

struct RoleInfoDrawingView: View {
    @StateObject var viewModel = RoleInfoViewModel()

    var body: some View {
        HStack {
            KFImage(URL(string: viewModel.avatar.iconURL ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120)
                .background(
                    LinearGradient(
                        gradient: viewModel.avatar.rarity.ratityColor,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            VStack {
                VStack {
                    Text(viewModel.avatar.itemName ?? "")
                        .boldModifier(size: 26)
                        .foregroundColor(.white)
                    Text(viewModel.avatar.level)
                        .sizeModifier(size: 20)
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
        count: 6
    )

    var body: some View {
        if viewModel.consumeSections.isEmpty {
            Text(CopyStarRailRole.finishedConsume)
                .boldModifier(size: 24)
                .frame(width: 280, height: 200)
                .background(.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
                                VStack(alignment: .trailing) {
                                    Text("\(item.itemName ?? "")")
                                    Text("\(item.num ?? 0)")
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Text(section.title)
                                .font(.system(size: 18, weight: .bold))
                                .padding(.leading, 20)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct RoleInfoSkillsComputeView: View {
    @StateObject var viewModel: RoleInfoViewModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 3
    )

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.skillsCompute.title)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            }
            LazyVGrid(columns: columns) {
                ForEach(viewModel.skillsCompute.consume) { item in
                    HStack {
                        StarRaillRarityView(
                            rarity: item.rarity ?? .one,
                            urlString: item.itemURL ?? ""
                        )
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .trailing) {
                            Text("\(item.itemName ?? "")")
                            Text("\(item.num ?? 0)")
                        }
                    }
                }
            }
        }
        .frame(minWidth: 350, maxWidth: 350)
    }
}

#Preview {
    RoleInfoView(id: "1111")
        .frame(width: 800, height: 400)
}
