//
//  MovieCollectionView.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 2/7/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class MovieCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCell", bundle:nil), forCellWithReuseIdentifier:"MovieCell");
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MovieCollectionView", owner: self, options: nil) 
        self.addSubview(contentView)
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError("Couldn't dequeue a cell") }
        
        return newsCell
    }
    
}
