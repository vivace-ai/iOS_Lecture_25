//
//  ColloectionViewController.swift
//  Collections
//
//  Created by Kim Young Hee on 2025-02-18.
//

import Foundation
import UIKit

class CollectionViewController : ViewController, UICollectionViewDataSource {
    
    let items = ["Item1", "Item2","Item3", "Item4"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        //start up code goes here
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.contentView.backgroundColor = .lightGray
        return cell
    }
    
    
    
    
    
}
