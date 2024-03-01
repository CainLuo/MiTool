//
//  WeightView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

struct WeightView: View {
    var body: some View {
        List {
            Section {
                StarRailWidgetCard()
                GenshinWidgetCard()
            } header: {
                Text("UID: 173612938123")
                    .font(.system(size: 26, weight: .bold))
            }
        }
        .frame(minWidth: 776,
               maxWidth: .infinity)
    }
}

#Preview {
    WeightView()
        .frame(width: 800, height: 1000)
}
