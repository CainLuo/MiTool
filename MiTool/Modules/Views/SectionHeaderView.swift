//
//  SectionHeaderView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/10.
//

import SwiftUI

struct SectionHeaderView: View {
    let userName: String
    let uid: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(userName)
                .font(.system(size: 18, weight: .semibold))
            Text(uid)
                .font(.system(size: 15))
        }
    }
}
