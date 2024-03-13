//
//  StarRailWidgetCard.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI
import Kingfisher

struct StarRailWidgetCard: View {
    @State var fill: CGFloat = 0
    @StateObject var viewModel = StarRailWidgetCardViewModel()
    
    var body: some View {
        HStack {
            StarRailWidgetInfoView(viewModel: viewModel)
            
            Divider()
            
            StarRailWidgetOtherCard(weightTypes: viewModel.localModels)
            
            Divider()
            
            if !viewModel.expeditions.isEmpty {
                StarRailExpeditionView(expeditions: viewModel.expeditions)
            }
        }
        .padding()
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .task {
            await viewModel.getStarRailWeight()
        }
    }
}

struct StarRailWidgetInfoView: View {
    enum IconSize {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }
    
    @StateObject var viewModel: StarRailWidgetCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("昵称：凹凸曼的小怪兽")
                .font(.system(size: 16, weight: .semibold))
            Text("UID：109020123")
                .font(.system(size: 16, weight: .semibold))
            
            HStack {
                Image("staminaIcon")
                    .circleModifier(width: IconSize.width,
                                    height: IconSize.height)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(CopyStarRailWeight.trailblazePower)
                    Text(viewModel.stamina)
                        .font(.system(size: 20, weight: .semibold))
                    Text(viewModel.recoveryTime)
                }
            }
            
            HStack {
                Image("reservedStaminaIcon")
                    .circleModifier(width: IconSize.width,
                                    height: IconSize.height)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(CopyStarRailWeight.reserveTrailblazePower)
                        Text(viewModel.reserveStamina)
                            .font(.system(size: 20, weight: .semibold))
                    }
                    Text(viewModel.reserveStaminaFull)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct StarRailWidgetOtherCard: View {
    let weightTypes: [StarRailLocalModel]
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 1
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(weightTypes, id: \.self) { type in
                HStack {
                    Text(type.name)
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(type.currentValue) / \(type.maxValue)")
                        .font(.system(size: 14))
                }
            }
        }
        .frame(minWidth: 150, maxWidth: .infinity)
    }
}

struct StarRailExpeditionView: View {
    enum AvatarSize {
        static let width: CGFloat = 40
        static let height: CGFloat = 40
    }
    
    enum ItemSize {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }

    let expeditions: [StarRailWeightExpeditionModel]
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(expeditions.indices, id: \.self) { index in
                let expedition = expeditions[index]
                VStack {
                    Text(expedition.timeString)
                    
                    HStack {
                        KFImage(URL(string: expedition.avatars?.first ?? ""))
                            .circleModifier(width: AvatarSize.width,
                                            height: AvatarSize.height)
                        
                        KFImage(URL(string: expedition.avatars?.last ?? ""))
                            .circleModifier(width: AvatarSize.width,
                                            height: AvatarSize.height)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 150)
    }
}

#Preview {
    StarRailWidgetCard()
        .frame(width: 750, height: 250)
}
