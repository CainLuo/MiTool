//
//  Text+Extensions.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import SwiftUI

extension Text {
    func boldModifier(size: CGFloat) -> some View {
        self
            .font(.system(size: size, weight: .bold))
    }
    
    func sizeModifier(size: CGFloat) -> some View {
        self
            .font(.system(size: size))
    }
}
