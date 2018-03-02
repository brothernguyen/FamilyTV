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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Label
        let nextMovie = UILabel(frame: CGRect(x: 1450, y: 150, width: 400, height: 50))
        nextMovie.backgroundColor = UIColor.black
        nextMovie.alpha = 0.3
        nextMovie.textColor = UIColor.white
        nextMovie.font = nextMovie.font.withSize(30)
        nextMovie.textAlignment = .center
        nextMovie.text = "Next movie plays in..10s"
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = CGRect(x: 1450, y: 150, width: 400, height: 240)
        avPlayerLayer.videoGravity = .resize
        avPlayerLayer.opacity = 0.7
        
        self.contentOverlayView?.layer.insertSublayer(avPlayerLayer, at: 0)
        self.view.addSubview(nextMovie)
        
        let url = NSURL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        let playerItem = AVPlayerItem(url: url! as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avPlayer.play()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Layout subviews manually
        
    }
    
}
