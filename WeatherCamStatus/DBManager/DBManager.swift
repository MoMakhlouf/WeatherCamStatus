//
//  DBManager.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 29/11/2022.
//

import Foundation
import CoreData

class DBManager {
    static let sharedInstance = DBManager()
    private init(){}
}

extension DBManager{
    
    func saveToDB(appDelegate : AppDelegate ,city : String , degree : Double , photo : Data , weatherStatus : String  ){
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Status", in: managedContext){
            
            let st = NSManagedObject(entity: entity, insertInto: managedContext)
            st.setValue(city, forKey: "city")
            st.setValue(degree, forKey: "degree")
            st.setValue(photo, forKey: "photo")
            st.setValue(weatherStatus, forKey: "weatherStatus")
            do{
                try managedContext.save()
            }catch{
                print("error")
            }
        }
        
    }
    
    func getStatusFromDB(appDelegate : AppDelegate) -> [Status] {
        
        var fetchedList : [Status] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName : "Status")
        
        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! [Status]
        } catch{
            print("error")
        }
        
        return fetchedList
        
    }
}
