//
//  NewsViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKNavigationDelegate {
    var newsTitle = String()
    var newsURL = String()
    
    @IBOutlet var close: UIButton!
    @IBOutlet var newstitle: UILabel!
    @IBOutlet var viewForUrl: UIView!
    @IBOutlet var newsWebView: WKWebView!
    @IBOutlet var loader: UILabel!

    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
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
    
    func createUI() {
        newstitle.font = UIFont.systemFont(ofSize: 14.0)
        newstitle.textColor = .white
        newsWebView.backgroundColor = .black
        newsWebView.isOpaque = false
        self.view.backgroundColor = .black
        loader.textColor = .white
        if (newsURL == nil) {
            loader.text = "Page Link is not available"
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loader.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

