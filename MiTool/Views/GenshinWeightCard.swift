//
//  GenshinWeightCard.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI
import Kingfisher

struct GenshinWeightCard: View {
    @StateObject var viewModel = GenshinWeightCardViewModel()

    var body: some View {
        VStack {
            HStack {
                Image("resin")
                    .circleModifier(width: 60, height: 60)
                VStack(spacing: 8) {
                    Text(CopyGenshinWeight.resin)
                    Text("\(viewModel.data.currentResin)/\(viewModel.data.maxResin)")
                        .font(.system(size: 24, weight: .semibold))
                }
            }
            Text(CopyGenshinWeight.recoveryTime)
            Text(viewModel.recoveryTime)

            Divider()

            GenshinWeightOtherCard(viewModel: viewModel)
                .padding([.top, .bottom])

            Divider()

            GenshinWeightExpeditionView(viewModel: viewModel)
                .padding(.top)
        }
        .onAppear {
            viewModel.getGenshinWeight()
        }
    }
}

struct GenshinWeightOtherCard: View {
    @StateObject var viewModel: GenshinWeightCardViewModel

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            GenshinWeightOtherCardSubview(
                iconName: "homeCoin",
                text: "\(viewModel.data.currentHomeCoin)/\(viewModel.data.maxHomeCoin)"
            )

            GenshinWeightOtherCardSubview(
                iconName: "resinDiscount",
                text: "\(viewModel.data.remainResinDiscountNum)/\(viewModel.data.resinDiscountNumLimit)"
            )

            GenshinWeightOtherCardSubview(
                iconName: "task",
                text: "\(viewModel.data.finishedTaskNum)/\(viewModel.data.totalTaskNum)"
            )

            GenshinWeightOtherCardSubview(
                iconName: "transformer",
                text: viewModel.data.transformerTime
            )
        }
    }
}

struct GenshinWeightExpeditionView: View {
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
                .background(.black.opacity(0.3))
                .cornerRadius(10)
            }
        }
    }
}


#Preview {
    GenshinWeightCard()
        .frame(width: 400, height: 600)
}

struct GenshinWeightOtherCardSubview: View {
    let iconName: String
    let text: String

    var body: some View {
        VStack {
            Image(iconName)
                .circleModifier(width: 40, height: 40)
            Text(text)
        }
    }
}
