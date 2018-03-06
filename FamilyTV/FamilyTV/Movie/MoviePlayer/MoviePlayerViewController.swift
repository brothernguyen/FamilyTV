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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Next movie label
        nextMovieLabel = UILabel(frame: CGRect(x: 1370, y: 150, width: 480, height: 22))
        nextMovieLabel.backgroundColor = UIColor.black
        nextMovieLabel.alpha = 0.6
        nextMovieLabel.textColor = UIColor.white
        nextMovieLabel.font = nextMovieLabel.font.withSize(22)
        nextMovieLabel.textAlignment = .center
        nextMovieLabel.isHidden = true
        self.view.addSubview(nextMovieLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func playMiniPlayer(_ url: URL) {
        debugPrint("==>Is video url valid?: ", UIApplication.shared.canOpenURL(url))
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = CGRect(x: 1370, y: 150, width: 480, height: 240)
        avPlayerLayer.videoGravity = .resize
        avPlayerLayer.opacity = 0.6
        self.contentOverlayView?.layer.insertSublayer(avPlayerLayer, at: 0)

        let playerItem = AVPlayerItem(url: url as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()        
        avPlayerLayer.opacity = 0.0
        avPlayer.pause()
        avPlayer.isMuted = true
    }
    
    func stopMiniPlayer() {
        nextMovieLabel.isHidden = true
        avPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Layout subviews manually
        
    }
    
}
