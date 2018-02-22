//
//  MovieCollectionView.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 2/7/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var categoryLabel: UILabel!
    
    var movieUrl: URL?
    var movies = [JSON]()
    var catMovies = [JSON]()
    var category = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MovieCollectionView", owner: self, options: nil) 
        self.addSubview(contentView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCell", bundle:nil), forCellWithReuseIdentifier:"MovieCell");
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
                if cat == self.category {
                    catMovies.append(movie)
                }
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        } else {
            //something went wrong!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else { fatalError("Couldn't dequeue a cell") }
        let movieItem = catMovies[indexPath.row]
        let thumbnail = movieItem["im:image"][2]["label"].stringValue
        if let imageURL = URL(string: thumbnail) {
            movieCell.loadingImg.load(imageURL)
        }
        movieCell.movieTitle.text = movieItem["title"]["label"].stringValue
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieItem = catMovies[indexPath.row]
        guard let videoUrl = URL(string: movieItem["link"][1]["attributes"]["href"].stringValue) else { return }        

        let player = AVPlayer(url: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        guard let topViewController = UIApplication.topViewController() else { return }
        topViewController.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension UIApplication {
    
    static func topViewController() -> UIViewController? {
        guard var top = shared.keyWindow?.rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
}
