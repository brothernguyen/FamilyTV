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
        
        channels.append(LiveTVModel.init(name: "HTV9", videoUrl: URL(string: "http://live.cdn.mobifonetv.vn/motv/myhtv9_hls.smil/chunklist_b1200000.m3u8")!)!)
        channels.append(LiveTVModel.init(name: "HTV7", videoUrl: URL(string: "http://live.cdn.mobifonetv.vn/motv/myhtv7_hls.smil/chunklist_b1200000.m3u8")!)!)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("==>count:", channels.count)
        return channels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? LiveTVCell else { fatalError("Couldn't dequeue a cell") }
        
        let newsItem = channels[indexPath.row]
        let title = newsItem.name
        //let thumbnail = newsItem["fields"]["thumbnail"].stringValue
        debugPrint("==>Title", title)
        
        newsCell.liveTVLabel.text = title
//        if let imageURL = URL(string: thumbnail) {
//            newsCell.liveTVImage.load(imageURL)
//        }
        
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
