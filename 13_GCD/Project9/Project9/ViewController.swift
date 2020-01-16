//
//  ViewController.swift
//  Project9
//
//  Created by Hiroki Ikeuchi on 2020/01/15.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        runBackgroundCode1()
//        runBackgroundCode2()
//        runBackgroundCode3()
//        runBackgroundCode4()
        
        runSynchronousCode()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @objc func log(message: String) {
        print("Printing message: \(message)")
    }
    
    func runBackgroundCode1() {
        performSelector(inBackground: #selector(log(message:)), with: "Hello world 1")
        performSelector(onMainThread: #selector(log(message:)), with: "Hello world 2", waitUntilDone: false)
        log(message: "Hello world 3")
    }
    
    func runBackgroundCode2() {
        DispatchQueue.global().async { [unowned self] in
            self.log(message: "On background thread")
            DispatchQueue.main.async {
                self.log(message: "On main thread")
            }
        }
    }
    
    func runBackgroundCode3() {
        DispatchQueue.global().async {
            guard let url = URL(string: "https://www.apple.com") else { return }
            guard let str = try? String(contentsOf: url) else { return }
            print(str)
        }
    }
    
    func runBackgroundCode4() {
        DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
            self.log(message: "This is high priority")
        }
    }
    
    func runSynchronousCode() {
        // asynchronous!
        DispatchQueue.global().async {
            print("Background thread 1")
        }
        print("Main thread 1")
        
        // synchronous!
        DispatchQueue.global().sync {
            print("Background thread 2")
        }
        print("Main thread 2")
    }
    
}

