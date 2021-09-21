//
//  CoreDataModel.swift
//  CodingTest
//
//  Created by Sheetal Jain on 19/09/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataModel : NSObject {
    
    private var newsViewModel : NewsViewModel!
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let newsEntity = NSEntityDescription.entity(forEntityName: "NewsArticle", in: managedContext)!
        
        for i in 1...5 {
            let news = NSManagedObject(entity: newsEntity, insertInto: managedContext)
            //news.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        }
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retreiveData(){
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsArticle")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                
            }
        } catch {
            print("failed")
        }
    }
    
    func deleteData(){
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsArticle")
        //fetchRequest.predicate = NSPredicate
    }
}
