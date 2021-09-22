//
//  CoreDataModel.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import Foundation
import UIKit
import CoreData

open class CoreDataModel : NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let entityName = "NewsArticle"
    
    
    func createData(news: Array<Any>) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let newsEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        var id = 1
        for item in news {
            let entry = item as? Article
            let newsObject = NSManagedObject(entity: newsEntity, insertInto: managedContext)
            newsObject.setValue(entry?.author, forKey: "author")
            newsObject.setValue(entry?.articleDescription, forKey: "articleDescription")
            newsObject.setValue(entry?.publishedAt, forKey: "publishedAt")
            newsObject.setValue(entry?.title, forKey: "title")
            newsObject.setValue(entry?.url, forKey: "url")
            newsObject.setValue(entry?.urlToImage, forKey: "urlToImage")
            newsObject.setValue(entry?.content, forKey: "content")
            newsObject.setValue(id, forKey: "id")
            id = id + 1
        }
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retreiveDataWithID() -> NewsCoreData? {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var latestRecord : NewsCoreData?
        fetchRequest.predicate = NSPredicate(
            format: "id = 1"
        )
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let publishedAt = data.value(forKey: "publishedAt") as? String
                let author = data.value(forKey: "author") as? String
                let title = data.value(forKey: "title") as? String
                let articleDescription = data.value(forKey: "articleDescription") as? String
                let url = data.value(forKey: "url") as? String
                let urlToImage = data.value(forKey: "urlToImage") as? String
                let content = data.value(forKey: "title") as? String
                let id = data.value(forKey: "id") as? Int
                
                latestRecord = NewsCoreData(author: author, title: title, articleDescription: articleDescription, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, id: id)
            }
        }
        catch {
            print("Failed")
        }
        return latestRecord
    }
    
    func retreiveData() -> [NewsCoreData]{
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let publishedAt = data.value(forKey: "publishedAt") as? String
                let author = data.value(forKey: "author") as? String
                let title = data.value(forKey: "title") as? String
                let articleDescription = data.value(forKey: "articleDescription") as? String
                let url = data.value(forKey: "url") as? String
                let urlToImage = data.value(forKey: "urlToImage") as? String
                let content = data.value(forKey: "title") as? String
                let id = data.value(forKey: "id") as? Int
                
                let dataToAppend = NewsCoreData(author: author, title: title, articleDescription: articleDescription, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, id: id)
                coreDataArray.append(dataToAppend)
                
            }
        } catch {
            print("Failed")
        }
        return coreDataArray
    }
    
    func deleteData(){
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsArticle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do
               {
                try managedContext.execute(deleteRequest)
                try managedContext.save()
               }
        catch
        {
            print ("There was an error")
        }
    }
}
