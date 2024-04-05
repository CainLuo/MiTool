//
//  ViewConfiguration.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/3.
//

import SwiftUI

enum Shape {
    case none
    case circle
    case roundedRectangle(cornerRadius: CGFloat)
}

struct ViewConfiguration {
    let shape: Shape
    let frame: CGSize
    let backgroundColor: Color?
    let borderColor: Color?
    let borderWidth: CGFloat

    init(
        shape: Shape = .none,
        frame: CGSize = CGSize(width: 90, height: 90),
        backgroundColor: Color? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0
    ) {
        self.shape = shape
        self.frame = frame
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}
