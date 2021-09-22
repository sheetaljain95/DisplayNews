//
//  NewsViewModel.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import Foundation

class NewsViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var newsData : [NewsCoreData]? {
        didSet {
            self.bindNewsViewModelToController()
        }
    }
    
    var bindNewsViewModelToController : (() -> ()) = {}
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetNewsData()
    }
    
    func callFuncToGetNewsData() {
        self.apiService.apiToGetNewsData { (newsData) in
            self.newsData = newsData.sorted { $0.author ?? "" < $1.author ?? "" }
            self.newsData = newsData
        }
    }
}
