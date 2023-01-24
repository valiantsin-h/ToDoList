//
//  ToDoList.swift
//  ToDoList
//
//  Created by Valiantsin Harshkou on 19.12.22.
//

import Foundation

struct ToDo: Equatable, Codable {
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, dueDate: Date,
       notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static let documentsDirectory =
       FileManager.default.urls(for: .documentDirectory,
       in: .userDomainMask).first!
    static let archiveURL =
       documentsDirectory.appendingPathComponent("toDos")
       .appendingPathExtension("plist")
    
    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else
           {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
           from: codedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
}
