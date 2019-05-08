//
//  LiveTVViewController.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 5/7/19.
//  Copyright © 2019 Tuan Anh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LiveTVViewController: UICollectionViewController {
    
    var apiKey = "138738ef-2a6d-44ac-bc0a-1b28a40c17fb"
    var articles = [JSON]()
    var channels = [LiveTVModel]()
    var playerViewController: MoviePlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Blur effect
        let imageView = UIImageView(image: UIImage(named: "background.png"))
        imageView.frame = view.bounds
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        view.addSubview(blurredEffectView)
        view.sendSubview(toBack: blurredEffectView)
        view.sendSubview(toBack: imageView)
        self.playerViewController = MoviePlayerViewController()
        
        channels.append(LiveTVModel.init(name: "ABC News Live", image: "https://i.imgur.com/DhyuABZ.png", videoUrl: URL(string: "https://abclive2-lh.akamaihd.net/i/abc_live11@423404/master.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "Bloomberg Television", image: "https://i.imgur.com/idRFfhY.png", videoUrl: URL(string: "https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_live.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "ACK TV", image: "https://web-cdn.blivenyc.com/generic/mee.logo-golden-trans.png", videoUrl: URL(string: "https://video.blivenyc.com/broadcast/prod/2061/22/file-3192k.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "AXS TV", image: "https://i.imgur.com/mexZF9k.png", videoUrl: URL(string: "http://161.0.157.6/PLTV/88888888/224/3221226568/index.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "Big Ten Network", image: "https://upload.wikimedia.org/wikipedia/en/b/b4/Big_Ten_Network.png", videoUrl: URL(string: "http://161.0.157.38/PLTV/88888888/224/3221226177/index.m3u8?fluxustv.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "Buzzr TV", image: "https://upload.wikimedia.org/wikipedia/en/b/be/Buzzr_%28TV_Network%29_Logo.png", videoUrl: URL(string: "https://buzzr.global.ssl.fastly.net/out/u/buzzr_hls_4.m3u8?fluxustv.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "BYU TV", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/BYUtv_logo.svg/1200px-BYUtv_logo.svg.png", videoUrl: URL(string: "https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master_4064.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "CBS News", image: "https://www.depauw.edu/files/resources/large_cbs-news.png", videoUrl: URL(string: "http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "CBS News", image: "https://www.depauw.edu/files/resources/large_cbs-news.png", videoUrl: URL(string: "http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "HTV9", image: "https://upload.wikimedia.org/wikipedia/commons/f/fe/HTV9.png", videoUrl: URL(string: "http://live.cdn.mobifonetv.vn/motv/myhtv9_hls.smil/chunklist_b1200000.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "HTV7", image: "https://upload.wikimedia.org/wikipedia/vi/4/4c/HTV7Logomoi.png", videoUrl: URL(string: "http://live.cdn.mobifonetv.vn/motv/myhtv7_hls.smil/chunklist_b1200000.m3u8")!)!)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? LiveTVCell else { fatalError("Couldn't dequeue a cell") }
        
        let newsItem = channels[indexPath.row]
        let title = newsItem.name
        let thumbnail = newsItem.image
        
        newsCell.liveTVLabel.text = title
        
        if let imageURL = URL(string: thumbnail) {
            newsCell.liveTVImage.load(imageURL)
        }
        return newsCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let playerViewController = self.playerViewController else { return }
        playerViewController.player = AVPlayer(url: channels[indexPath.row].videoUrl!)
        guard let topViewController = UIApplication.topViewController() else { return }
        
        topViewController.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}

class LiveTVCell: UICollectionViewCell {
    
    @IBOutlet weak var liveTVImage: RemoteImageView!
    @IBOutlet weak var liveTVLabel: UILabel!
    @IBOutlet var unfocusedConstraint: NSLayoutConstraint!
    
    var focusedConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        focusedConstraint = liveTVLabel.topAnchor.constraint(equalTo: liveTVImage.focusedFrameGuide.bottomAnchor, constant: 15)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
//        focusedConstraint.isActive = isFocused
//        unfocusedConstraint.isActive = !isFocused
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        super.didUpdateFocus(in: context, with: coordinator)
        setNeedsUpdateConstraints()
        
        coordinator.addCoordinatedAnimations({
            self.layoutIfNeeded()
        })
    }
}
