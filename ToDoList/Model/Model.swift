//
//  Model.swift
//  ToDoList
//
//  Created by Alisher on 1/20/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import Foundation


var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoItemKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let arr = UserDefaults.standard.array(forKey: "ToDoItemKey") as? [[String: Any]] {
            return arr
        } else {
            return []
        }
    }
}

func addItem(title: String, subtitle: String, deadline: String, isCompleted: Bool = false) {
    ToDoItems.append(["Title": title, "Subtitle": subtitle, "Deadline": deadline, "isCompleted": isCompleted])
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
}

func changeState(at index: Int) -> Bool {
    if (ToDoItems[index]["isCompleted"] as! Bool) == true {
        ToDoItems[index]["isCompleted"] = false
        return false
    } else {
        ToDoItems[index]["isCompleted"] = true
        return true
    }
}

func editItem(at index: Int, title: String, subtitle: String, deadline: String) {
    ToDoItems[index]["Title"] = title
    ToDoItems[index]["Subtitle"] = subtitle
    ToDoItems[index]["Deadline"] = deadline
}
