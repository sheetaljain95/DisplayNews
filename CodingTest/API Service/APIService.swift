//
//  APIService.swift
//  CodingTest
//
//  Created by Sheetal Jain on 18/09/21.
//

import Foundation

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=a0f4350cf91f4cbfb2c4372966569c59")!
    
    func apiToGetNewsData(completion : @escaping (News) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                //use if let
                let newsData = try! jsonDecoder.decode(News.self, from: data)
                completion(newsData)
            }
        }.resume()
    }
}
