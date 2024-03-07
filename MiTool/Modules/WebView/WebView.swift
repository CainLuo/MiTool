//
//  WebView-SwiftUI.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/7.
//

import WebKit
import SwiftUI

struct WiKiMap: View {
    @StateObject var viewModel = WebViewModel()
    
    @Binding var selection: SideBarType
    
    var body: some View {
        WebView(url: viewModel.url)
            .task {
                viewModel.fetchURL(sideBarType: selection)
            }
    }
}

#if os(macOS)
struct WebView: NSViewRepresentable {
    let url: URL?
    
    typealias NSViewType = WKWebView
    
    func makeNSView(context: Context) -> WKWebView {
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = webpagePreferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        nsView.load(request)
    }
}

#else
struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = webpagePreferences
        
        return WKWebView(frame: .zero, configuration: configuration)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
#endif
