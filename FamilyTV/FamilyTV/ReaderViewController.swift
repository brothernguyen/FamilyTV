//
//  ReaderViewController.swift
//  FamilyTV
//
//  Created by Tuan Anh on 1/20/18.
//  Copyright © 2018 Tuan Anh. All rights reserved.
//

import UIKit

class ReaderViewController: UIViewController {
    
    @IBOutlet var headLine: UILabel!
    @IBOutlet var imageView: RemoteImageView!
    @IBOutlet var body: UITextView!
    
    var article: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let article = article else { return }
        
        body.panGestureRecognizer.allowedTouchTypes = [UITouchType.indirect.rawValue] as [NSNumber]
        body.isSelectable = true
        
        if let url = article["fields"]["thumbnail"].url {
            
            imageView.load(url)
            imageView.layer.borderColor = UIColor.darkGray.cgColor
            imageView.layer.borderWidth = 2
            imageView.layer.cornerRadius = 20
        }
        
        headLine.text = article["fields"]["headline"].stringValue
        body.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black]
        
        let articleBody = article["fields"]["body"].stringValue
        let formattedArticleBody = formatHTML(articleBody)
        
        if let articleBodyData = formattedArticleBody.data(using: .utf8) {
            
            // if let bodyText = try? NSAttributedString(data: articleBodyData, options: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            if let bodyText = try? NSAttributedString(data: articleBodyData, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],documentAttributes: nil) {
                
                body.attributedText = bodyText
                
            }
        }
    }
    
    func formatHTML(_ html: String) -> String {        
        
        guard let wrapperURL = Bundle.main.url(forResource: "wrapper", withExtension: "html") else { return html }
        guard let wrapper = try? String(contentsOf: wrapperURL) else { return html }
        
        return wrapper.replacingOccurrences(of: "%@", with: html)
    }
   
}
