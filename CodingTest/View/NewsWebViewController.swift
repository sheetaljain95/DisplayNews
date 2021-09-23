//
//  NewsViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    @IBOutlet var close: UIButton!
    @IBOutlet var newstitle: UILabel!
    @IBOutlet var viewForUrl: UIView!
    @IBOutlet var newsWebView: WKWebView!
    @IBOutlet var loader: UILabel!
    
    // MARK: - Actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Variables
    var newsTitle = String()
    var newsURL = String()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.newstitle.text = newsTitle
        guard let link = URL(string:newsURL) else { return  }
        let request = URLRequest(url: link)
        newsWebView.load(request)
        newsWebView.navigationDelegate = self
    }
    
    // MARK: - View Methods
    func createUI() {
        newstitle.font = UIFont.systemFont(ofSize: 14.0)
        newstitle.textColor = .white
        newsWebView.backgroundColor = .black
        newsWebView.isOpaque = false
        self.view.backgroundColor = .black
        loader.textColor = .white
    }
    
    // MARK: - WKWebView Methods
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loader.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.text = error.localizedDescription
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loader.text = error.localizedDescription
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

