//
//  ButtonFactory.swift
//  MiTool
//
//  Created by Cain on 2024/4/3.
//

import SwiftUI

/// Enum defining different button styles
enum ButtonStyle {
    case primary // Primary style
    case secondary // Secondary style
    case tertiary // Tertiary style
    case directory // Directory style
    case ghost // Ghost style
    case custom(ButtonStyleConfiguration) // Custom style
}

/// Configuration for the button style
struct ButtonStyleConfiguration {
    var textColor: Color // Text color
    var buttonColor: Color // Button background color
    var borderColor: Color? // Optional button border color
    var borderLineWidth: CGFloat = 1 // Optional button border line width
    var cornerRadius: CGFloat = 10 // Set the corner radius, default: 5
}

/// Factory class for creating buttons
struct ButtonFactory {
    /// Creates a button with the specified style, title, and action
    /// - Parameters:
    ///   - style: ButtonStyle
    ///   - title: String
    ///   - isDisabled: Bool, default: true
    ///   - action: @escaping () -> Void
    /// - Returns: View
    static func makeButton(
        with style: ButtonStyle,
        title: String, 
        isDisabled: Bool = true,
        action: @escaping () -> Void
    ) -> some View {
        var configuration: ButtonStyleConfiguration
        
        // Select the configuration based on the style
        switch style {
        case .primary:
            configuration = ButtonStyleConfiguration(
                textColor: .white,
                buttonColor: .blue,
                borderColor: nil
            )
        case .secondary:
            configuration = ButtonStyleConfiguration(
                textColor: .blue,
                buttonColor: .white,
                borderColor: .blue
            )
        case .tertiary:
            configuration = ButtonStyleConfiguration(
                textColor: .green,
                buttonColor: .white,
                borderColor: .green
            )
        case .directory:
            configuration = ButtonStyleConfiguration(
                textColor: .black, 
                buttonColor: .yellow,
                borderColor: .black
            )
        case .ghost:
            configuration = ButtonStyleConfiguration(
                textColor: .purple,
                buttonColor: .clear, 
                borderColor: .purple
            )
        case .custom(let customConfig):
            configuration = customConfig
        }
        
        // Create the button view
        return Button(action: action) {
            Text(title)
                .foregroundColor(configuration.textColor) // Set the text color
                .padding() // Add padding
                .background(configuration.buttonColor) // Set the background color
                .cornerRadius(configuration.cornerRadius) // Set the corner radius
                .overlay(
                    configuration.borderColor.map {
                        RoundedRectangle(cornerRadius: configuration.cornerRadius)
                            .stroke($0, lineWidth: configuration.borderLineWidth) // Add the border
                    }
                )
        }
        .buttonStyle(.plain) // Set the button style to PlainButtonStyle
        .disabled(isDisabled)
    }
}

#if DEBUG
import SwiftUI

struct ButtonFactory_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonFactory.makeButton(with: .primary, title: "Primary Button") {}
            ButtonFactory.makeButton(with: .secondary, title: "Secondary Button") {}
            ButtonFactory.makeButton(with: .tertiary, title: "Tertiary Button") {}
            ButtonFactory.makeButton(with: .directory, title: "Directory Button") {}
            ButtonFactory.makeButton(with: .ghost, title: "Ghost Button") {}
        }
        .padding()
    }
}
#endif
