//
//  MoviePlayerViewController.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 2/28/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MoviePlayerViewController: AVPlayerViewController {
    
    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    var nextMovieLabel = UILabel()
    var countdownLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Next movie label
        nextMovieLabel = UILabel(frame: CGRect(x: 1450, y: 150, width: 400, height: 50))
        nextMovieLabel.backgroundColor = UIColor.black
        nextMovieLabel.alpha = 0.6
        nextMovieLabel.textColor = UIColor.white
        nextMovieLabel.font = nextMovieLabel.font.withSize(30)
        nextMovieLabel.textAlignment = .center
        nextMovieLabel.text = "Next movie plays in     s"
        nextMovieLabel.isHidden = true
        self.view.addSubview(nextMovieLabel)
        
        //Countdown label
        countdownLabel = UILabel(frame: CGRect(x: 1750, y: 150, width: 50, height: 50))
        countdownLabel.backgroundColor = UIColor.clear
        countdownLabel.alpha = 0.6
        countdownLabel.textColor = UIColor.white
        countdownLabel.font = nextMovieLabel.font.withSize(30)
        countdownLabel.textAlignment = .center
        countdownLabel.isHidden = true
        self.view.addSubview(countdownLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func playMiniPlayer(_ url: URL) {
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = CGRect(x: 1450, y: 150, width: 400, height: 240)
        avPlayerLayer.videoGravity = .resize
        avPlayerLayer.opacity = 0.6
        self.contentOverlayView?.layer.insertSublayer(avPlayerLayer, at: 0)

//        let url = NSURL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        let playerItem = AVPlayerItem(url: url as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
        nextMovieLabel.isHidden = false
        countdownLabel.isHidden = false
    }
    
    func stopMiniPlayer() {
        nextMovieLabel.isHidden = true
        countdownLabel.isHidden = true
        avPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Layout subviews manually
        
    }
    
}
