//
//  ViewController.swift
//  Project7
//
//  Created by Hiroki Ikeuchi on 2020/01/05.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var collectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


extension ViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt
        indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Photo"),
                                           for: indexPath)
        guard let pictureItem = item as? Photo else { return item }
        
        pictureItem.view.wantsLayer = true
        pictureItem.view.layer?.backgroundColor = NSColor.red.cgColor
        
        return pictureItem
    }
}
