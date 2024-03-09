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
                        StarRailWidgetCard()
                        GenshinWidgetCard()
                    } header: {
                        VStack(alignment: .leading) {
                            Text(section.title)
                                .font(.system(size: 26, weight: .bold))
                            Text(section.uidString)
                                .font(.system(size: 26, weight: .bold))
                        }
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
