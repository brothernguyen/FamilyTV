//
//  MovieViewController.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/28/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class MovieViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError("Couldn't dequeue a cell") }
        
        return movieCell
    }
    
}
