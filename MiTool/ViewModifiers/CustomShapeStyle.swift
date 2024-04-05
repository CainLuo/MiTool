//
//  CustomShapeStyle.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/3.
//

import SwiftUI

struct CustomShapeStyle: ViewModifier {
    let shape: Shape
    let size: CGSize
    let color: Color

    func body(content: Content) -> some View {
        switch shape {
        case .circle:
            content
                .frame(width: size.width, height: size.height)
                .clipShape(Circle())
                .foregroundColor(color)
        case .roundedRectangle(let cornerRadius):
            content
                .frame(width: size.width, height: size.height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .foregroundColor(color)
        default:
            content
        }
    }
}

extension View {
    func customStyle(shape: Shape, size: CGSize, color: Color) -> some View {
        self.modifier(CustomShapeStyle(shape: shape, size: size, color: color))
    }
}
