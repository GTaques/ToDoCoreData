//
//  ContentView.swift
//  ToDoCoreData
//
//  Created by Gabriel Taques on 26/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems : FetchedResults<ToDoItem>
    @State var toDoItemTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add new ToDo")) {
                    HStack {
                        TextField("Title", text: self.$toDoItemTitle)
                        Spacer()
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.toDoItemTitle
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            self.toDoItemTitle = ""
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }.disabled(self.toDoItemTitle.isEmpty)
                    }
                }
                Section(header: Text("Items")) {
                    ForEach(toDoItems, id: \.id) { todo in
                        Text("\(todo.title)")
                    }.onDelete(perform: deleteItem)
                }
            }
            .navigationBarTitle("ToDo List")
            .navigationBarItems(trailing: EditButton())
            
        }
    }
    
    func deleteItem(at indexSet: IndexSet) {
        let itemToDelete = self.toDoItems[indexSet.first!]
        self.managedObjectContext.delete(itemToDelete)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
