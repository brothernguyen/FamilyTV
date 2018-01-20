//
//  RemoteImageView.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/19/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class RemoteImageView: UIImageView {

    var url: URL?
    
    func getCachesDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load(_ imgURL: URL) {        
        
        self.url = imgURL
        guard let savedFilename = imgURL.absoluteString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else { return }
        
        let fullPath = getCachesDirectory().appendingPathComponent(savedFilename)
        
        if FileManager.default.fileExists(atPath: fullPath.path) {
            image = UIImage(contentsOfFile: fullPath.path)
            return
        }
       
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData = try? Data(contentsOf: imgURL) else { return }
            
            try? imageData.write(to: fullPath)
            
            if self.url == imgURL {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }

}
