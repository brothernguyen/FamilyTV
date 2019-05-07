//
//  LiveTVModel.swift
//  FamilyTV
//
//  Created by Anh Tuan Nguyen on 5/7/19.
//  Copyright © 2019 Tuan Anh. All rights reserved.
//

import Foundation

class LiveTVModel: NSObject {
    var name: String
    
    var videoUrl: URL?
    
    init?(name: String, videoUrl: URL) {
        self.name = name        
        self.videoUrl = videoUrl
    }
}
