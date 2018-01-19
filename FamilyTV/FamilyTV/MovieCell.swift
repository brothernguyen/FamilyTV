//
//  MovieCell.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/10/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: RemoteImageView!
    @IBOutlet weak var movieTextLabel: UILabel!
    
    @IBOutlet var unfocusedConstraint: NSLayoutConstraint!
    var focusedConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        // Move down the text label a bit when cell gets focused
        focusedConstraint = movieTextLabel.topAnchor.constraint(equalTo: movieImageView.focusedFrameGuide.bottomAnchor, constant: 15)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        focusedConstraint.isActive = isFocused
        unfocusedConstraint.isActive = !isFocused
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        setNeedsUpdateConstraints()
        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()
        })
    }
}
