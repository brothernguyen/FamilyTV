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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Label
//        let nextMovie = UILabel(frame: CGRect(x: 660, y: 400, width: 600, height: 350))
//        nextMovie.backgroundColor = UIColor.lightGray
//        nextMovie.alpha = 0.8
//        nextMovie.textColor = UIColor.darkGray
//        nextMovie.textAlignment = .center
//        nextMovie.text = "Next movie plays in.. 10s"
//        nextMovie.isHidden = true
//        self.contentOverlayView?.addSubview(nextMovie)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
