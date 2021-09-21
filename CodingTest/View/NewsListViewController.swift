//
//  ViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import UIKit

class NewsListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var newTableView: UITableView!
    private var newsViewModel : NewsViewModel?
    private let newscell = "NewsTableViewCell"
    
    // MARK: - Table view Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel?.newsData?.count ?? 0
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newscell, for: indexPath) as! NewsTableViewCell
        cell.delegate = self
        cell.cellNewsTitle = self.newsViewModel?.newsData?[indexPath.row].title
        cell.cellNewsURL = self.newsViewModel?.newsData?[indexPath.row].url
        cell.updateCell(news: (self.newsViewModel?.newsData?[indexPath.row])!)
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - view Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        uiUpdate()
        let nib = UINib.init(nibName: newscell, bundle: nil)
        self.newTableView.register(nib, forCellReuseIdentifier: newscell)
    }
    
    // MARK: - Methods
    
    func createUI(){
        topView.layer.cornerRadius = 24
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.addSubview(topView)
        self.view.backgroundColor = .black
        self.newTableView.backgroundColor = .black
        self.newTableView.separatorColor = UIColor.black
    }
    
    func uiUpdate(){
        self.newsViewModel =  NewsViewModel()
        self.newsViewModel!.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.newTableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

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
