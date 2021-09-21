//
//  NewsTableViewCell.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import UIKit
import Foundation
import SDWebImage

protocol SeeNewsDelegate {
    func didTapButton(newsTitle: String?, newsURL: String?)
}

class NewsTableViewCell : UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet var title: UILabel!
    @IBOutlet var fullNews: UIButton!
    @IBOutlet var newsContent: UILabel!
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var author: UILabel!
    @IBOutlet var newsView: UIView!
    
    var cellNewsTitle : String?
    var cellNewsURL : String?
    var delegate: SeeNewsDelegate!

    // MARK: - Methods
    @IBAction func seeFullNews(_ sender: Any) {
        delegate.didTapButton(newsTitle: cellNewsTitle, newsURL: cellNewsURL)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
  
    func createUI(){
        newsView.backgroundColor = UIColor.darkGray
        newsView.layer.cornerRadius = 5
        newsContent.textColor = .white
        newsContent.font = UIFont.systemFont(ofSize: 12.0)
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 13.0)
        author.textColor = .white
        author.font = UIFont.systemFont(ofSize: 10.0)
        fullNews .setTitleColor(.white, for: .normal)
        fullNews .setTitleColor(.lightGray, for: .selected)
        fullNews.backgroundColor = .gray
        fullNews.layer.cornerRadius = 5
        fullNews.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 14.0)
        newsImage.contentMode = .scaleAspectFill
        newsImage.layer.cornerRadius = 5

    }
    
    func updateCell(news: Article) {
        title.text = news.title
        newsContent.text = news.articleDescription
        if (news.urlToImage != nil) {
            self.newsImage.sd_setImage(with: URL(string: news.urlToImage!))
        } else {
            newsImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: newsImage!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0).isActive = true        }
        author.text = news.author
        if (news.author == nil) {
            author.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: author!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0).isActive = true
        }
    }
}

