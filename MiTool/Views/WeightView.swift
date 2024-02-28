//
//  WeightView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

struct WeightView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                StarRailWeightCard()
                    .frame(minWidth: 450, 
                           maxWidth: .infinity)

                Divider()
                
                GenshinWeightCard()
                    .frame(minWidth: 400, 
                           maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    WeightView()
        .frame(width: 800, height: 1000)
}
