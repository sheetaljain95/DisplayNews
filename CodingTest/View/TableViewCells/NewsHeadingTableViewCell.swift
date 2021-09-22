//
//  NewsHeadingTableViewCell.swift
//  CodingTest
//
//  Created by Sheetal Jain on 23/09/21.
//

import UIKit

protocol CloseButtonTappedDelegate {
    func didTapButton()
}

class NewsHeadingTableViewCell: UITableViewCell {
    @IBOutlet var topView: UIView!
    @IBOutlet var view: UIView!
    
    var delegate: ButtonTappedDelegate!

    @IBAction func closeButtonTapped(_ sender: Any) {
        delegate.didTapButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
    func createUI(){
        topView.layer.cornerRadius = 24
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = .black
        view.addSubview(topView)
    }
    
}
