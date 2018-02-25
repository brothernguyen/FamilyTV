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
    
    var movieDetail = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
    }
    
    func initLayout() {
        movieTitle.text = movieDetail["im:name"]["label"].stringValue
        price.text = movieDetail["im:price"]["label"].stringValue
        let thumbnail = movieDetail["im:image"][2]["label"].stringValue
        if let imageURL = URL(string: thumbnail) {
            img.load(imageURL)
        }
    }

    @IBAction func playMovie(_ sender: Any) {
        guard let movieUrl = URL(string: movieDetail["link"][1]["attributes"]["href"].stringValue) else { return }
        let player = AVPlayer(url: movieUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        guard let topViewController = UIApplication.topViewController() else { return }
        topViewController.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
