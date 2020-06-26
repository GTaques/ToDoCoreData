//
//  ToDoItem.swift
//  ToDoCoreData
//
//  Created by Gabriel Taques on 26/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import Foundation
import CoreData

class ToDoItem: NSManagedObject, Identifiable {
    
    var id = UUID()
    @NSManaged var createdAt: Date
    @NSManaged var title: String
    
}

extension ToDoItem {
    
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
