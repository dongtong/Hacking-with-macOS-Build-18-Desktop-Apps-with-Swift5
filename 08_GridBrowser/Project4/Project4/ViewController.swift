//
//  ViewController.swift
//  Project4
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKNavigationDelegate {
    
    var rows: NSStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1: create the stackView and add it to our view
        rows = NSStackView()
        rows.orientation = .vertical // デフォルトは.horizontal
        rows.distribution = .fillEqually    // 等間隔
        rows.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rows)
        
        // 2: Create Auto Layout constraints that pin the stack view to the edges of its container
        rows.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rows.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rows.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rows.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // 3: Create an initial column that contains a single web view
        let column = NSStackView(views: [makeWebView()])
        column.distribution = .fillEqually
        
        // 4: Add this column to the `rows` stack view
        rows.addArrangedSubview(column)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func urlEntered(_ sender: NSTextField) {
        
    }
    
    @IBAction func navigationClicked(_ sender: NSSegmentedControl) {
        
    }
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
        
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
        
    }
    
    func makeWebView() -> NSView {
        
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.wantsLayer = true
        webView.load(URLRequest(url: URL(string: "https://www.apple.com")!))
        
        return webView
    }
}

