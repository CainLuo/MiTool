//
//  CookieJSWebView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import WebKit
import SwiftUI

struct CookieJSWebView: View {
    let viewModel = CookieJSWebViewModel()
    
    var body: some View {
        VStack {
            CookieWebView(viewModel: viewModel)
            
            Button(action: {
                viewModel.readCookie()
            }, label: {
                Text("Save Button")
                    .frame(width: 200, height: 50)
                    .foregroundStyle(Color.white)
                    .background(.blue)
                    .cornerRadius(8)
            })
            .padding()
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear {
            viewModel.loadWebViewContnet()
        }
    }
}

class CookieJSWebViewModel: ObservableObject {
    @Published var webResource: String?
    var webView: WKWebView

    init(webResource: String? = nil) {
        self.webResource = webResource
        
        self.webView = WKWebView(frame: .zero,
                                 configuration: WKWebViewConfiguration())
    }
    
    func loadWebViewContnet() {
        guard let url = URL(string: ApiKeys.Mihoyo.login.rawValue) else {
            print("Bad URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func readCookie() {
        webView.evaluateJavaScript("document.cookie") { [weak self] result, error in
            print("get cookie success: \(result)")
            print("error: \(error)")
        }
    }
}

#if os(macOS)
struct CookieWebView: NSViewRepresentable {
    var viewModel: CookieJSWebViewModel
    
    typealias NSViewType = WKWebView
    
    init(viewModel: CookieJSWebViewModel) {
        self.viewModel = viewModel
    }
    
    func makeNSView(context: Context) -> WKWebView {
        viewModel.webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
}

#else
struct CookieWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var viewModel: CookieJSWebViewModel

    init(viewModel: CookieJSWebViewModel) {
        self.viewModel = viewModel
    }

    func makeUIView(context: Context) -> WKWebView {
        viewModel.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
}
#endif

extension CookieWebView {
    class Coordinator: NSObject {
        var viewModel: CookieJSWebViewModel
        
        init(viewModel: CookieJSWebViewModel) {
            self.viewModel = viewModel
        }
    }
}
