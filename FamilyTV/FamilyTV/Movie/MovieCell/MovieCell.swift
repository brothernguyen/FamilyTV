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
    @IBOutlet var movieTitle: UILabel!
    
    @IBOutlet var unfocusedConstraint: NSLayoutConstraint!
    var focusedConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        focusedConstraint = movieTitle.topAnchor.constraint(equalTo: loadingImg.focusedFrameGuide.bottomAnchor, constant: 15)
    }
    
    //This method will be called by didUpdateFocus method
    override func updateConstraints() {
        super.updateConstraints()
        
        focusedConstraint.isActive = isFocused
        unfocusedConstraint.isActive = !isFocused
        
        movieTitle.textColor = self.isFocused ? UIColor.white : UIColor.darkGray
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        setNeedsUpdateConstraints()
        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()            
        })
    }
    
    override var canBecomeFocused : Bool {
        return true
    }
}
