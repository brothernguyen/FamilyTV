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
    var movies = [JSON]()
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(tvOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
     
        guard let url = URL(string: "http://itunes.apple.com/us/rss/topmovies/limit=200/json") else { return }
        
        //Load categories
        self.loadData(url: url)
        
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 1920, height: 500))
        img.image = UIImage(named: "banner.png")
        scrollView.addSubview(img)
        
        //Blur effect
        let imageView = UIImageView(image: UIImage(named: "banner.png"))        
        imageView.frame = view.bounds
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        view.addSubview(blurredEffectView)
        
        view.sendSubview(toBack: blurredEffectView)
        view.sendSubview(toBack: imageView)
        
    }
    
    func loadData(url: URL) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetch(url)
        }
    }
    
    func fetch(_ url: URL) {
        if let data = try? Data(contentsOf: url) {
            movies = JSON(data)["feed"]["entry"].arrayValue
            for movie in movies {
                let cat = movie["category"]["attributes"]["label"].stringValue
                categories.append(cat)
            }
            
            //Remove duplicated elements
            categories = Array(Set(categories))            
                        
            DispatchQueue.main.async {
                var yPosition = 500
                for i in 0..<self.categories.count {
                    let movieView = MovieCollectionView.init(frame: CGRect(x: 0, y: yPosition, width: 1920, height: 520))                    
                    movieView.categoryLabel.text = self.categories[i]
                    movieView.category = self.categories[i]
                    movieView.loadData(url: url)                    
                    self.scrollView.addSubview(movieView)
                    yPosition += 600
                    self.sections.append(movieView)
                }
                self.scrollView.contentSize = CGSize(width: 1920, height: yPosition + 200)
            }
        } else {
            //something went wrong!
        }
    }
        
}
