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
    
    var photos = [URL]()
    
    lazy var photoDirectory: URL = {
        let fm = FileManager.default
        let paths = fm.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let saveDirectory = documentDirectory.appendingPathComponent("SlideMark")
        print("\(saveDirectory.path)")
        
        if !fm.fileExists(atPath: saveDirectory.path) {
            try? fm.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
        }
        
        return saveDirectory
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let fm = FileManager.default
            let files = try fm.contentsOfDirectory(at: photoDirectory, includingPropertiesForKeys: nil)
            
            for file in files {
                if file.pathExtension == "jpg" || file.pathExtension == "png" || file.pathExtension == "PNG" {
                    photos.append(file)
                }
            }
        } catch {
            // failed to read the save directory
            print("Set up error")
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


extension ViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt
        indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Photo"),
                                           for: indexPath)
        guard let pictureItem = item as? Photo else { return item }
        
        pictureItem.view.wantsLayer = true
        
        let image = NSImage(contentsOf: photos[indexPath.item])
        pictureItem.imageView?.image = image
        
        return pictureItem
    }
}
