//
//  DisplayListView.swift
//  CodingTest
//
//  Created by Sheetal Jain on 20/09/21.
//

import UIKit
import Foundation


protocol ButtonTappedDelegate {
    func didTapButton()
}

class DisplayListView: UIView {
    @IBOutlet var displayList: UILabel!
    var delegate: ButtonTappedDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.displayList.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.labelClicked(_:)))
        displayList.addGestureRecognizer(gesture)
    }
    
    @objc func labelClicked(_ sender:UITapGestureRecognizer) {
        delegate.didTapButton()
    }
}
