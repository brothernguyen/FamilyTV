//
//  NewsCell.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 2/6/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet var newsImageView: RemoteImageView!
    @IBOutlet var newsTextLabel: UILabel!
    
    @IBOutlet var unfocusedConstraint: NSLayoutConstraint!
    
    var focusedConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        focusedConstraint = newsTextLabel.topAnchor.constraint(equalTo: newsImageView.focusedFrameGuide.bottomAnchor, constant: 15)
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
