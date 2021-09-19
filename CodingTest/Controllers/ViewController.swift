//
//  ViewController.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var newTableView: UITableView!
    private var newsViewModel : NewsViewModel!
    
    // MARK: - Table view Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel.newsData?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.updateCell(news: (self.newsViewModel.newsData?.articles[indexPath.row])!)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - view Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiUpdate()
        let nib = UINib.init(nibName: "NewsTableViewCell", bundle: nil)
        self.newTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
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

