//
//  ViewController.swift
//  Family TV
//
//  Created by Tuan Anh on 1/8/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var apiKey = "138738ef-2a6d-44ac-bc0a-1b28a40c17fb"
    var articles = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let title = title else { return }        
        guard let url = URL(string: "https://content.guardianapis.com/\(title.lowercased())?api-key=\(apiKey)&show-fields=thumbnail,headline,standfirst,body") else { return }
                
        DispatchQueue.global(qos: .userInteractive).async {
            
            self.fetch(url)
        }
    }
    
    func fetch(_ url: URL) {
        
        if let data = try? Data(contentsOf: url) {
            articles = JSON(data)["response"]["results"].arrayValue
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        } else {
            //something went wrong!
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCell else { fatalError("Couldn't dequeue a cell") }
        
        let newsItem = articles[indexPath.row]
        let title = newsItem["fields"]["headline"].stringValue
        let thumbnail = newsItem["fields"]["thumbnail"].stringValue
        
        newsCell.movieTextLabel.text = title
        
        if let imageURL = URL(string: thumbnail) {
            
            newsCell.movieImageView.load(imageURL)
        }
        
        return newsCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let reader = storyboard?.instantiateViewController(withIdentifier: "Reader") as? ReaderViewController else { return }
        
        reader.article = articles[indexPath.row]
        present(reader, animated: true)
    }
    
}

