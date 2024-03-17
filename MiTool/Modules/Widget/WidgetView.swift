//
//  WidgetView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

struct WidgetView: View {
    @StateObject var viewModel = WidgetViewModel()
    
    var body: some View {
        if viewModel.widgetSections.isNotEmpty {
            List {
                ForEach(viewModel.widgetSections) { section in
                    Section {
                        StarRailWidgetCard(widgetItem: section.starRailItem)
                        GenshinWidgetCard()
                    } header: {
                        SectionHeaderView(
                            userName: section.title,
                            uid: section.uidString
                        )
                    }
                }
            }
            .frame(minWidth: 776,
                   maxWidth: .infinity)
        } else {
            VStack {
                Text("暂无任何游戏记录")
            }
            .task {
                viewModel.getWidgetSections()
            }
        }
    }
}

#Preview {
    WidgetView()
        .frame(width: 800, height: 1000)
}
