//
//  GenshinWidgetCard.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI
import Kingfisher

struct GenshinWidgetCard: View {
    @StateObject var viewModel = GenshinWeightCardViewModel()

    var body: some View {
        HStack {
            GenshinWidgetInfoView(viewModel: viewModel)
            
            Divider()
                .padding([.top, .bottom], 20)
            
            GenshinWidgetDailyNodeCard(viewModel: viewModel)
                .padding([.top, .bottom])
            
            Divider()
                .padding([.top, .bottom], 20)
            
            GenshinWidgetExpeditionView(viewModel: viewModel)
                .padding(.top)
        }
        .padding()
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .task {
            viewModel.getGenshinWeight()
        }
    }
}

struct GenshinWidgetInfoView: View {
    @StateObject var viewModel: GenshinWeightCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("昵称：凹凸曼的小怪兽")
                .font(.system(size: 16, weight: .semibold))
            Text("UID：109020123")
                .font(.system(size: 16, weight: .semibold))
            
            HStack {
                Image("resin")
                    .circleModifier(width: 50, height: 50)
                VStack(spacing: 8) {
                    Text(CopyGenshinWeight.resin)
                    Text(viewModel.data.resinContent)
                        .font(.system(size: 20, weight: .semibold))
                    Text(viewModel.recoveryTime)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct GenshinWidgetDailyNodeCard: View {
    @StateObject var viewModel: GenshinWeightCardViewModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        VStack {
            ForEach(viewModel.dailyNodes) { item in
                let content = item.otherContent ?? item.valueContent
                GenshinWidgetOtherCardSubview(
                    iconName: item.iconNmae,
                    text: content
                )
            }
        }
        .frame(minWidth: 150, maxWidth: .infinity)
    }
}

struct GenshinWidgetOtherCardSubview: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack {
            Image(iconName)
                .circleModifier(width: 40, height: 40)
            Text(text)
        }
        .frame(minWidth: 150)
    }
}

struct GenshinWidgetExpeditionView: View {
    @StateObject var viewModel: GenshinWeightCardViewModel
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(viewModel.data.expeditions ?? []) { item in
                HStack {
                    KFImage(URL(string: item.avatarSideIcon))
                        .circleModifier(width: 50, height: 50)
                        .padding(.bottom)

                    Text(item.remainedTimeString)
                }
                .padding([.leading, .trailing], 10)
            }
        }
        .frame(minWidth: 350)
    }
}

#Preview {
    GenshinWidgetCard()
        .frame(width: 750, height: 284)
}
