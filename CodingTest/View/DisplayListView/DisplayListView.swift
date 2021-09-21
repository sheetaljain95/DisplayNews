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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    func commonInit() {
        let view = Bundle.main.loadNibNamed("DisplayListView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @objc func labelClicked(_ sender:UITapGestureRecognizer) {
        delegate.didTapButton()
    }
}
