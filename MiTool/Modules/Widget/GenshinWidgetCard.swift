//
//  GenshinWidgetCard.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI
import Kingfisher

struct GenshinWidgetCard: View {
    @StateObject var viewModel = GenshinWidgetCardViewModel()

    var widgetItem: WidgetSectionItem

    var body: some View {
        HStack {
            GenshinWidgetInfoView(
                uid: widgetItem.uidString,
                nickname: widgetItem.nicknameString,
                viewModel: viewModel
            )
            
            Divider()
            
            GenshinWidgetDailyNodeCard(viewModel: viewModel)
            
            Divider()
            
            GenshinWidgetExpeditionView(viewModel: viewModel)
        }
        .padding()
        .background(.black.opacity(0.4))
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.getGenshinWidget(item: widgetItem)
        }
    }
}

struct GenshinWidgetInfoView: View {
    enum IconSize {
        static let width: CGFloat = 50
        static let height: CGFloat = 50
    }

    var uid = ""
    var nickname = ""

    @StateObject var viewModel: GenshinWidgetCardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(nickname)
                .font(.system(size: 16, weight: .semibold))
            Text(uid)
                .font(.system(size: 16, weight: .semibold))
            
            HStack {
                Image("resin")
                    .circleModifier(
                        width: IconSize.width,
                        height: IconSize.height
                    )
                VStack(spacing: 8) {
                    Text(CopyGenshinWidget.resin)
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
    @StateObject var viewModel: GenshinWidgetCardViewModel

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
            Spacer()
            Text(text)
        }
        .frame(minWidth: 150, maxWidth: 150)
    }
}

struct GenshinWidgetExpeditionView: View {
    @StateObject var viewModel: GenshinWidgetCardViewModel
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(viewModel.data.expeditions ?? []) { item in
                KFImage(URL(string: item.avatarSideIcon))
                    .circleModifier(width: 50, height: 50)
                    .padding(.bottom)
                    .padding([.leading, .trailing], 10)
            }
        }
        .frame(minWidth: 350)
    }
}

#Preview {
    GenshinWidgetCard(widgetItem: WidgetSectionItem())
        .frame(width: 750, height: 284)
}
