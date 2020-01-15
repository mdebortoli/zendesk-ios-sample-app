//
//  HomeController.swift
//  Zendesk Demo
//
//  Created by Marcelo De Bortoli  on 13/01/2020.
//  Copyright © 2020 EMEA Presales. All rights reserved.
//

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/

import UIKit
import WebKit

class HomeController: UIViewController, UINavigationControllerDelegate, WKNavigationDelegate {
    
    @IBOutlet var webViewContainer: UIView!
    
    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userScript = WKUserScript(source: config.script, injectionTime: .atDocumentStart, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)

        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: webViewContainer.bounds, configuration: webViewConfiguration)

        if let webView = webView {
            webView.translatesAutoresizingMaskIntoConstraints = false

            webViewContainer.addSubview(webView)
            let bindings: [String: AnyObject] = ["webView": webView]
        webViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: bindings))
        webViewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: bindings))

            let request = URLRequest(url: URL(string: config.url)!)
            webView.load(request)
        }
    }

}

/*
/////////////////////////////////////////////////////////////////////////////
// DO NOT CHANGE ANYTHING ON THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING   //
/////////////////////////////////////////////////////////////////////////////
*/
