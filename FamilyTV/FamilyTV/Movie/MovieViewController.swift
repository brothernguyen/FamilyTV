//
//  MovieViewController.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/28/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var sections = [MovieCollectionView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let img = UIImageView(frame: CGRect(x: 0, y: -50, width: 1920, height: 500))
        img.image = UIImage(named: "banner.png")
        scrollView.addSubview(img)
        
        var yPosition = 450
        for i in 0..<5 {
            let movieView = MovieCollectionView.init(frame: CGRect(x: 0, y: yPosition, width: 1920, height: 578))
            scrollView.addSubview(movieView)
            yPosition += 650
        }
        
        
        scrollView.contentSize = CGSize(width: 1920, height: yPosition + 600)
        
    }
        
}
