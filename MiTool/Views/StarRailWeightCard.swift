//
//  StarRailWeightCard.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI
import Kingfisher

struct StarRailWeightCard: View {
    enum IconSize {
        static let width: CGFloat = 80
        static let height: CGFloat = 80
    }
    
    @State var fill: CGFloat = 0
    @StateObject var viewModel = StarRailWeightCardViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Image("staminaIcon")
                                .circleModifier(width: IconSize.width,
                                              height: IconSize.height)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(CopyStarRailWeight.trailblazePower)
                                Text(viewModel.stamina)
                                    .font(.system(size: 26, weight: .semibold))
                            }
                        }
                        
                        VStack {
                            Text(viewModel.recoveryTime)
                            ProgressView(value: viewModel.staminaLastTime)
                                .tint(viewModel.staminaColor)
                                .frame(width: 200)
                        }
                    }
                    
                    VStack {
                        Image("reservedStaminaIcon")
                            .circleModifier(width: IconSize.width,
                                          height: IconSize.height)
                        Text(viewModel.reserveStamina)
                        Text(viewModel.reserveStaminaFull)
                    }
                    .padding()
                }
            }

            Divider()

            StarRailWeightOtherCard(weightTypes: viewModel.localModels)
            
            Divider()

            if !viewModel.expeditions.isEmpty {
                StarRailExpeditionView(expeditions: viewModel.expeditions)
            }
        }
        .onAppear {
            viewModel.getStarRailWeight()
        }
    }
}

struct StarRailWeightOtherCard: View {
    let weightTypes: [StarRailLocalModel]
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(weightTypes, id: \.self) { type in
                VStack(spacing: 10) {
                    Text(type.name)
                        .font(.system(size: 16, weight: .bold))
                    Text("\(type.currentValue) / \(type.maxValue)")
                        .font(.system(size: 15))
                }
                .padding([.leading, .trailing])
            }
        }
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
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(expeditions.indices, id: \.self) { index in
                let expedition = expeditions[index]
                HStack {
                    let statusColor: Color = expedition.status == .ongoing ? .orange : .green
                                   
                    ZStack {
                        // Tack circle
                        Circle()
                            .stroke(Color.white.opacity(0.3),
                                    style: StrokeStyle(lineWidth: 8))
                            .frame(width: ItemSize.width + 10,
                                   height: ItemSize.height + 10)
                        
                        // Animation circle
                        ZStack {
                            KFImage(URL(string: expedition.itemURL))
                                .circleModifier(width: ItemSize.width,
                                              height: ItemSize.height)
                                .clipShape(Circle())

                            Circle()
                                .trim(from: 0, to: expedition.timeProgress)
                                .stroke(statusColor,
                                        style: StrokeStyle(lineWidth: 8))
                                .frame(width: ItemSize.width + 10,
                                       height: ItemSize.height + 10)
                                .rotationEffect(.init(degrees: -90))
                                .animation(.linear, value: 0.5)
                        }
                    }
                    .padding()

                    VStack {
                        Text(expedition.name)

                        HStack {
                            KFImage(URL(string: expedition.avatars?.first ?? ""))
                                .circleModifier(width: AvatarSize.width,
                                              height: AvatarSize.height)
                            
                            KFImage(URL(string: expedition.avatars?.last ?? ""))
                                .circleModifier(width: AvatarSize.width,
                                              height: AvatarSize.height)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StarRailWeightCard()
        .frame(width: 400, height: 600)
}
