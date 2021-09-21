//
//  AnimationViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import UIKit

class AnimationViewController: UIViewController, ButtonTappedDelegate {
    
    @IBOutlet var centreXConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        let gesture = UITapGestureRecognizer(target: self, action: Selector(("buttonClicked:")))
        self.animationView.addGestureRecognizer(gesture)
    }
    
    
    
    @objc func buttonClicked(_ sender:UITapGestureRecognizer){
        if (self.widthConstraint.constant == 140) {
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.loadNib()
            } , completion: { finished in
                print("Animation!")
            })
        } else {
            self.animationView.translatesAutoresizingMaskIntoConstraints = false
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.widthConstraint.constant = 140
                self.heightConstraint.constant = 140
                self.centreXConstraint.constant = self.view.frame.midX-70
                self.animationView.backgroundColor = UIColor(red: 81/255, green: 140/255, blue: 146/255, alpha: 1)
                self.animationView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }, completion: { finished in
                print("Animation!")
            })
        }
    }
    
    func loadNib() {
        DispatchQueue.main.async {
            //var displayview = DisplayListView()
            let displayview = Bundle.main.loadNibNamed("DisplayListView", owner: nil, options: nil)![0] as! UIView as! DisplayListView
            displayview.delegate = self
            self.view.addSubview(displayview)
            displayview.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = displayview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            let verticalConstraint = displayview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            let widthConstraint = displayview.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
            let heightConstraint = displayview.heightAnchor.constraint(equalToConstant: self.view.frame.size.height)
            self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
            displayview.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    func createUI(){
        animationView.layer.cornerRadius = 6
    }
    
    func didTapButton() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

