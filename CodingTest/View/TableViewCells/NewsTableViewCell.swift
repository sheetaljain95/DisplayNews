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
    
    @IBOutlet var authorHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
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
        newsView.backgroundColor = UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
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
        newsContent.textColor = .lightGray
        
    }
    
    func updateCell(news: NewsCoreData) {
        title.text = news.title
        newsContent.text = news.articleDescription
        if let newsURL = news.urlToImage {
            self.newsImage.sd_setImage(with: URL(string: newsURL))
        } else {
            newsImage.translatesAutoresizingMaskIntoConstraints = false
            imageHeightConstraint.constant = 0
        }
        if let newsAuthor = news.author {
            author.text = newsAuthor
            authorHeightConstraint.constant = 0
        }
        else {
            author.translatesAutoresizingMaskIntoConstraints = false
           
        }
    }
}

