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
    var itemsBeingDragged: Set<IndexPath>?
    
    lazy var photosDirectory: URL = {
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
        
        collectionView.registerForDraggedTypes([NSPasteboard.PasteboardType(kUTTypeURL as String)])
        
        do {
            let fm = FileManager.default
            let files = try fm.contentsOfDirectory(at: photosDirectory, includingPropertiesForKeys: nil)
            
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
    
    func collectionView(_ collectionView: NSCollectionView,
                        validateDrop draggingInfo: NSDraggingInfo,
                        proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>,
                        dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>)
        -> NSDragOperation {
            return .move
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        draggingSession session: NSDraggingSession,
                        willBeginAt screenPoint: NSPoint,
                        forItemsAt indexPaths: Set<IndexPath>) {
        itemsBeingDragged = indexPaths
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        draggingSession session: NSDraggingSession,
                        endedAt screenPoint: NSPoint,
                        dragOperation operation: NSDragOperation) {
        itemsBeingDragged = nil
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        acceptDrop draggingInfo: NSDraggingInfo,
                        indexPath: IndexPath,
                        dropOperation: NSCollectionView.DropOperation) -> Bool {
        if let moveItems = itemsBeingDragged?.sorted() {
            // this is an internal drag
            performInternalDrag(with: moveItems, to: indexPath)
        } else {
            // this is an external drag
            let pasteboard = draggingInfo.draggingPasteboard
            guard let items = pasteboard.pasteboardItems else { return true }
            
            performExternalDrag(with: items, at: indexPath)
        }
        
        return true
    }
    
    func performInternalDrag(with items: [IndexPath], to indexPath: IndexPath) {
        
    }
    
    func performExternalDrag(with items: [NSPasteboardItem], at indexPath: IndexPath) {
        let fm = FileManager.default
        
        // 1 - loop over every item on the drag and drop pasteboard
        for item in items {
            // 2 - pull out the string containing the URL for this item
            guard let stringURL = item.string(forType: NSPasteboard.PasteboardType(kUTTypeFileURL as String)) else { continue }
            
            // 3 - attempt to convert the string into a real URL
            guard let sourceURL = URL(string: stringURL) else { continue }
            
            // 4 - create a destination URL by combining photosDirectory with the last path component
            let destinationURL = photosDirectory.appendingPathComponent(sourceURL.lastPathComponent)
            
            do {
                // 5 - attempt to copuy the file to our app's folder
                try fm.copyItem(at: sourceURL, to: destinationURL)
            } catch {
                print("Could not copy \(sourceURL)")
            }
            
            // 6 - update the array and collention view
            photos.insert(destinationURL, at: indexPath.item)
            collectionView.insertItems(at: [indexPath])
        }
        
    }
    
}

