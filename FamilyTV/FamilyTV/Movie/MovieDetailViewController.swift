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
    var movieUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func playMovie(_ sender: Any) {
        guard let movieUrl = self.movieUrl else { return }
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
