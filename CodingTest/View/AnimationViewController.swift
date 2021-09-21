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
    var backgroundView: DisplayListView!
    var backgroundViewLeading: NSLayoutConstraint!
    var backgroundViewTrailing: NSLayoutConstraint!
    var backgroundViewTop: NSLayoutConstraint!
    var backgroundViewBottom: NSLayoutConstraint!
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.animationView.addGestureRecognizer(gesture)
    }
    
    @objc func viewTapped(_ sender:UITapGestureRecognizer){
        if (self.widthConstraint.constant == 140) {
            UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.expandBackgroundView()
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
    
    func expandBackgroundView() {
        DispatchQueue.main.async {
            self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
            self.animationView.translatesAutoresizingMaskIntoConstraints = false
            self.centreXConstraint.isActive = false
            self.widthConstraint.isActive = false
            self.heightConstraint.isActive = false
            self.animationView.isHidden = true
            self.backgroundViewLeading = self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
            self.backgroundViewTrailing = self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            self.backgroundViewTop = self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor)
            self.backgroundViewBottom = self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            NSLayoutConstraint.activate([self.backgroundViewLeading, self.backgroundViewLeading, self.backgroundViewLeading, self.backgroundViewLeading])
            self.view.bringSubviewToFront(self.backgroundView)
            self.animationView.isHidden = true
            self.backgroundView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    func createUI(){
        animationView.layer.cornerRadius = 6
        backgroundView = DisplayListView()
        self.view.addSubview(backgroundView)
        //self.view.bringSubviewToFront(animationView)
        /*backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewLeading = backgroundView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor)
        backgroundViewTrailing = backgroundView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor)
        backgroundViewTop = backgroundView.topAnchor.constraint(equalTo: animationView.topAnchor)
        backgroundViewBottom = backgroundView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor)
        NSLayoutConstraint.activate([backgroundViewLeading, backgroundViewLeading, backgroundViewLeading, backgroundViewLeading])*/
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func didTapButton() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

