//
//  MovieDetailViewController.swift
//  FamilyTV
//
//  Created by Tuan Anh on 2/23/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailViewController: UIViewController {

    @IBOutlet var playMovieButton: UIButton!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var img: RemoteImageView!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var movieIndex = 0
    var catMovies = [JSON]()
    var image: UIImage?
    var playerViewController: MoviePlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerViewController = MoviePlayerViewController()
        self.initLayout()
    }
        
    func initLayout() {
        let movieDetail = catMovies[movieIndex]
        movieTitle.text = movieDetail["im:name"]["label"].stringValue
        price.text = "Available to buy on iTunes for " + movieDetail["im:price"]["label"].stringValue
        category.text = movieDetail["category"]["attributes"]["label"].stringValue
        artist.text = movieDetail["im:artist"]["label"].stringValue
        
        summary.isSelectable = true
        summary.isScrollEnabled = true
        summary.isUserInteractionEnabled = true
        summary.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]
        summary.text = movieDetail["summary"]["label"].stringValue
        
        let thumbnail = movieDetail["im:image"][2]["label"].stringValue
        if let imageURL = URL(string: thumbnail) {
            img.load(imageURL)
            self.image = img.image
        }
        
        releaseDate.text = movieDetail["im:releaseDate"]["attributes"]["label"].stringValue
        
        //Blur effect
        let imageView = UIImageView(image: self.image)       
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

    @IBAction func playMovie(_ sender: Any) {
        guard let movieUrl = URL(string: catMovies[movieIndex]["link"][1]["attributes"]["href"].stringValue) else { return }
                
        guard let playerViewController = self.playerViewController else { return }
        playerViewController.player = AVPlayer(url: movieUrl)        
        guard let topViewController = UIApplication.topViewController() else { return }
                
        topViewController.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
        let currentItem = playerViewController.player?.currentItem
        let duration = currentItem?.duration
        debugPrint("==>duration: ", CMTimeGetSeconds(duration!))
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailViewController.movieEnded), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)                
    }
    
    @objc func movieEnded() {
        
        //Play next movie
        self.movieIndex += 1
        if self.movieIndex == catMovies.count {
            removePlayer()
            return
        }
        guard let movieUrl = URL(string: catMovies[movieIndex]["link"][1]["attributes"]["href"].stringValue) else { return }
        let player = AVPlayer(url: movieUrl)
        guard let playerViewController = self.playerViewController else { return }
        playerViewController.player = player
        playerViewController.player!.play()
    }
    
    func removePlayer() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
       dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
