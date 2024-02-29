//
//  MiToolApp.swift
//  MiTool
//
//  Created by Cain Luo on 2024/1/30.
//

import SwiftUI
#if os(macOS)
import AppKit
#else
import UIKit
#endif

@main
struct MiToolApp: App {
#if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
#else
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
#endif

    var body: some Scene {
        WindowGroup {
            ContentView(selection: .notes)
        }
//        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        SQLManager.shared.connectDataBase()
    }
}

#else
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        SQLManager.shared.connectDataBase()
        return true
    }
}

#endif
