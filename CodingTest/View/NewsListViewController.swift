//
//  ViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import UIKit

class NewsListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, ButtonTappedDelegate {
    
    // MARK: - Outlets
    @IBOutlet var topView: UIView!
    @IBOutlet weak var newTableView: UITableView!
    private var newsViewModel : NewsViewModel?
    private let newscell = "NewsTableViewCell"
    private let firstCell = "NewsHeadingTableViewCell"
    
    
    // MARK: - Table view Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel?.newsData?.count ?? 0 + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 128
        } 
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row != 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: newscell, for: indexPath) as! NewsTableViewCell
            cell.delegate = self
            cell.cellNewsTitle = self.newsViewModel?.newsData?[indexPath.row].title
            cell.cellNewsURL = self.newsViewModel?.newsData?[indexPath.row].url
            cell.updateCell(news: (self.newsViewModel?.newsData?[indexPath.row])!)
            cell.backgroundColor = .black
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: firstCell, for: indexPath) as! NewsHeadingTableViewCell
            cell.delegate = self
            return cell
            
        }
    }
    
    
    // MARK: - view Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        uiUpdate()
        let newsnib = UINib.init(nibName: newscell, bundle: nil)
        self.newTableView.register(newsnib, forCellReuseIdentifier: newscell)
        let topnib = UINib.init(nibName: firstCell, bundle: nil)
        self.newTableView.register(topnib, forCellReuseIdentifier: firstCell)
    }
    
    // MARK: - Methods
    
    func createUI(){
        /*topView.layer.cornerRadius = 24
         topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
         view.addSubview(topView)
         self.view.backgroundColor = .black*/
        self.newTableView.backgroundColor = .black
        self.newTableView.separatorColor = UIColor.black
    }
    
    func uiUpdate(){
        self.newsViewModel =  NewsViewModel()
        self.newsViewModel!.bindNewsViewModelToController = {
            self.updateData()
        }
    }
    
    
    func updateData(){
        DispatchQueue.main.async {
            self.newTableView.reloadData()
        }
    }
    
    // MARK: - Status Bar 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Extension
extension NewsListViewController: SeeNewsDelegate {
    func didTapButton(newsTitle: String?, newsURL: String?) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsWebViewController") as? NewsWebViewController
        if let newstitle = newsTitle {
            vc!.newsTitle = newstitle
        }
        if let newsurl = newsURL {
            vc!.newsURL = newsurl
        }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

extension NewsListViewController: CloseButtonTappedDelegate {
    func didTapButton() {
        navigationController?.popViewController(animated: true)
    }
}
