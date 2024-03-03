//
//  WeightView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

struct WeightView: View {
    @StateObject var viewModel = WidgetViewModel()
    
    var body: some View {
        List {
            Section {
                StarRailWidgetCard()
                GenshinWidgetCard()
            } header: {
                VStack(alignment: .leading) {
                    Text("噼里啪啦")
                        .font(.system(size: 26, weight: .bold))
                    Text("UID: 173612938123")
                        .font(.system(size: 26, weight: .bold))
                }
            }
        }
        .frame(minWidth: 776,
               maxWidth: .infinity)
        .task {
            
        }
    }
}

#Preview {
    WeightView()
        .frame(width: 800, height: 1000)
}
