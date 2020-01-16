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
        
//        runSynchronousCode()
        
//        runMultiProcessing1()
        
        runMultiProcessing2(useGCD: true)
        runMultiProcessing2(useGCD: false)
        
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
    
    // Main thread 1
    // Background thread 1
    // Background thread 2
    // Main thread 2
    func runSynchronousCode() {
        // asynchronous!（非同期）
        DispatchQueue.global().async {
            print("Background thread 1")
        }
        print("Main thread 1")
        
        // synchronous!（同期）
        DispatchQueue.global().sync {
            print("Background thread 2")
        }
        print("Main thread 2")
    }
    
    func runMultiProcessing1() {
        DispatchQueue.concurrentPerform(iterations: 10) {   // run 10 threads
            print($0)
        }
    }
    
    func runMultiProcessing2(useGCD: Bool) {
        // フィナボッチ数列計算
        func fibonacci(of num: Int) -> Int {
            if num < 2 {
                return num
            } else {
                return fibonacci(of: num - 1) + fibonacci(of: num - 2)
            }
        }
        
        var array = Array(0 ..< 42)
        let start = CFAbsoluteTimeGetCurrent()
        
        if useGCD {
            DispatchQueue.concurrentPerform(iterations: array.count) {
                array[$0] = fibonacci(of: $0)
            }
        } else {
            for i in 0 ..< array.count {
                array[i] = fibonacci(of: array[i])
            }
        }
        let end = CFAbsoluteTimeGetCurrent() - start
        
        // use GCD     : Took 8.620744943618774 seconds
        // not use GCD : Took 11.588165998458862 seconds
        print("Took \(end) seconds")
    }
}

