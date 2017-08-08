//
//  CategoriesCollectionViewController.swift
//  Campus Cash Coupons
//
//  Created by Tyler Jordan Cagle on 8/7/17.
//  Copyright © 2017 COAD. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController {
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    var mainController: MainView?
    var images = ["Automotive", "Books", "Food", "Health", "Hotels", "Miscellaneous", "Retail", "Salons", "Services", "Tanning"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! CategoriesCollectionViewCell
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected row is", indexPath.row)
    }
    
}
