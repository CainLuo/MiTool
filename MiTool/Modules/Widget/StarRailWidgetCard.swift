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
    
    var widgetItem: WidgetSectionItem
    
    var body: some View {
        HStack {
            StarRailWidgetInfoView(
                uid: widgetItem.uidString,
                nickname: widgetItem.nicknameString,
                viewModel: viewModel
            )
            
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
        .onAppear {
            viewModel.fetchStarRailWidget(item: widgetItem)
        }
    }
}

struct StarRailWidgetInfoView: View {
    enum IconSize {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }
    
    var uid = ""
    var nickname = ""

    @StateObject var viewModel: StarRailWidgetCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(nickname)
                .font(.system(size: 16, weight: .semibold))
            Text(uid)
                .font(.system(size: 16, weight: .semibold))
            
            HStack {
                Image("staminaIcon")
                    .circleModifier(width: IconSize.width,
                                    height: IconSize.height)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(CopyStarRailWidget.trailblazePower)
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
                        Text(CopyStarRailWidget.reserveTrailblazePower)
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
                .frame(height: 40)
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

    let expeditions: [StarRailWidgetExpeditionModel]
    
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
    StarRailWidgetCard(widgetItem: .init())
        .frame(width: 750, height: 250)
}
