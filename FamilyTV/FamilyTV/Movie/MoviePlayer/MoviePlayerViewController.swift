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
        self.view.backgroundColor = UIColor.yellow      
        
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
