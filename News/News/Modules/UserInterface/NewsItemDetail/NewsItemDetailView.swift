//
//  NewsItemDetailView.swift
//  News
//
//  Created by Someshubhra Karmakar on 14/08/24.
//

import SwiftUI
import WebKit

struct NewsItemDetailView: View {
    let viewModel: NewsItemDetailViewModel
    let webView = WebView()
    
    var body: some View {
        VStack {
            webView
        }
        .onAppear() {
            webView.loadUrl(viewModel.newsItem.url)
        }
    }
}


struct WebView: UIViewRepresentable {
    
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
   
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func loadUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
