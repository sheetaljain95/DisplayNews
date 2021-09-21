//
//  ViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var newTableView: UITableView!
    private var newsViewModel : NewsViewModel!
    private let newscell = "NewsTableViewCell"
    
    // MARK: - Table view Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel.newsData?.articles?.count ?? 0
    }
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newscell, for: indexPath) as! NewsTableViewCell
        cell.delegate = self
        cell.cellNewsTitle = self.newsViewModel.newsData?.articles?[indexPath.row].title
        cell.cellNewsURL = self.newsViewModel.newsData?.articles?[indexPath.row].url
        cell.updateCell(news: (self.newsViewModel.newsData?.articles?[indexPath.row])!)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - view Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        uiUpdate()
        let nib = UINib.init(nibName: newscell, bundle: nil)
        self.newTableView.register(nib, forCellReuseIdentifier: newscell)
    }
    
    // MARK: - Methods
    
    func uiUpdate(){
        self.newsViewModel =  NewsViewModel()
        self.newsViewModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.newTableView.reloadData()
        }
    }
}

extension ViewController: SeeNewsDelegate {
        func didTapButton(newsTitle: String?, newsURL: String?) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsWebViewController") as? NewsWebViewController
        vc!.newsTitle = newsTitle!
        if (newsURL != nil) {
            vc!.newsURL = newsURL!
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
