//
//  MovieCellCollectionViewCell.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/30/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var loadingImg: RemoteImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadingImg.adjustsImageWhenAncestorFocused = true
    }
    
    override var canBecomeFocused : Bool {
        return true
    }
}
