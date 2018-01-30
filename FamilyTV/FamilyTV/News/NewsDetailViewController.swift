//
//  ReaderViewController.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/20/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet var newsHeadLine: UILabel!
    @IBOutlet var newsImageView: RemoteImageView!
    @IBOutlet var newsBody: UITextView!
    
    var article: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        guard let article = article else { return }
        
        newsBody.panGestureRecognizer.allowedTouchTypes = [UITouchType.indirect.rawValue] as [NSNumber]
        newsBody.isSelectable = true
        
        if let url = article["fields"]["thumbnail"].url {
            
            newsImageView.load(url)
            newsImageView.layer.borderColor = UIColor.darkGray.cgColor
            newsImageView.layer.borderWidth = 2
            newsImageView.layer.cornerRadius = 20
        }
        
        newsHeadLine.text = article["fields"]["headline"].stringValue
        newsBody.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black]
        
        let articleBody = article["fields"]["body"].stringValue
        let formattedArticleBody = formatHTML(articleBody)
        
        if let articleBodyData = formattedArticleBody.data(using: .utf8) {
            
            // if let bodyText = try? NSAttributedString(data: articleBodyData, options: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            if let bodyText = try? NSAttributedString(data: articleBodyData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],documentAttributes: nil) {
                
                newsBody.attributedText = bodyText
                
            }
        }
        newsBody.font = UIFont.systemFont(ofSize: 40)
    }
    
    func formatHTML(_ html: String) -> String {        
        
        guard let wrapperURL = Bundle.main.url(forResource: "wrapper", withExtension: "html") else { return html }
        guard let wrapper = try? String(contentsOf: wrapperURL) else { return html }
        
        return wrapper.replacingOccurrences(of: "%@", with: html)
    }
   
}
