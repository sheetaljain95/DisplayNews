//
//  AnimationViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import UIKit

class AnimationViewController: UIViewController, ButtonTappedDelegate {
    
    // MARK: - Outlets
    @IBOutlet var centreXConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var animationView: UIView!
    
    // MARK: - Variables
    var backgroundView: DisplayListView!
    var backgroundViewLeading: NSLayoutConstraint!
    var backgroundViewTrailing: NSLayoutConstraint!
    var backgroundViewTop: NSLayoutConstraint!
    var backgroundViewBottom: NSLayoutConstraint!
    
    // MARK: - View Methods
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        let animationViewGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.animationView.addGestureRecognizer(animationViewGesture)
        
        let backgroundViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        self.backgroundView.addGestureRecognizer(backgroundViewGesture)
    }
    
    // MARK: - Methods
    @objc func viewTapped(_ sender:UITapGestureRecognizer){
        if (self.widthConstraint.constant == 140) {
            UIView.animate(withDuration: 1.0, animations: {
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
            })
        }
    }
    
    func expandBackgroundView() {
        backgroundView.isHidden = false
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        let scaletransform = CGAffineTransform(scaleX: UIScreen.main.bounds.size.width/self.backgroundView.frame.size.width, y: UIScreen.main.bounds.size.height/self.backgroundView.frame.size.height)
        self.backgroundView.transform = scaletransform
        //self.view.bringSubviewToFront(self.backgroundView)
        self.animationView.isHidden = true
    }
    
    func createUI(){
        animationView.layer.cornerRadius = 16
        backgroundView = DisplayListView()
        self.view.addSubview(backgroundView)
        self.view.bringSubviewToFront(animationView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewLeading = backgroundView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor)
        backgroundViewTrailing = backgroundView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor)
        backgroundViewTop = backgroundView.topAnchor.constraint(equalTo: animationView.topAnchor)
        backgroundViewBottom = backgroundView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor)
        NSLayoutConstraint.activate([backgroundViewLeading, backgroundViewTrailing, backgroundViewTop, backgroundViewBottom])
        backgroundView.isHidden = true
    }

    @objc func didTapButton() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}

