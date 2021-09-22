//
//  NewsCoreData.swift
//  CodingTest
//
//  Created by Sheetal Jain on 21/09/21.
//

import Foundation

var coreDataArray = [NewsCoreData]()

struct NewsCoreData : Equatable {
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let id : Int?
}

