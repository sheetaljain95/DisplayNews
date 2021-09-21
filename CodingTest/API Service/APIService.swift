//
//  APIService.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import Foundation

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=a0f4350cf91f4cbfb2c4372966569c59")!
    let coreDataModel = CoreDataModel()
    
    func apiToGetNewsData(completion : @escaping (News) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let newsData = try! jsonDecoder.decode(News.self, from: data)
                var receivedRecords = [NewsCoreData]()
                // First Record From the Api
                let firstRecordApi = newsData.articles?.first
                let publishDateApi = firstRecordApi?.publishedAt
                // First Record From Core Data
                let firstRecordCoreData = self.coreDataModel.retreiveDataWithID()
                let publishDateCoreData = firstRecordCoreData?.publishedAt
                if (publishDateApi != publishDateCoreData) {
                    // delete core data
                    self.coreDataModel.deleteData()
                    self.coreDataModel.createData(news: newsData.articles!)
                    // update Core Data
                }
                receivedRecords = self.coreDataModel.retreiveData()
                
                completion(newsData)
            }
        }.resume()
    }
}
