//
//  TableViewController.swift
//  ToDoList
//
//  Created by Alisher on 1/20/21.
//  Copyright © 2021 Alisher. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addNewItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Create", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Subtitle"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Deadline"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { (alert) in
            let title1 = alertController.textFields![0].text
            let subtitle1 = alertController.textFields![1].text
            let deadline1 = alertController.textFields![2].text
            addItem(title: title1!, subtitle: subtitle1!, deadline: deadline1!)
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = ToDoItems[indexPath.row]
        cell.textLabel?.text = item["Title"] as? String
        if (item["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "check")
        } else {
            cell.imageView?.image = UIImage(named: "cancel")
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //for editing
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Edit list item", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = ToDoItems[indexPath.row]["Title"] as? String
            }
            alert.addTextField { (textField) in
                textField.text = ToDoItems[indexPath.row]["Subtitle"] as? String
            }
            alert.addTextField { (textField) in
                textField.text = ToDoItems[indexPath.row]["Deadline"] as? String
            }
            
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                let title2 = alert.textFields![0].text
                let subtitle2 = alert.textFields![1].text
                let deadline2 = alert.textFields![2].text
                editItem(at: indexPath.row, title: title2!, subtitle: subtitle2!, deadline: deadline2!)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })
        editAction.backgroundColor = UIColor.blue
        
        //for deleting
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        })
        
        return [deleteAction, editAction]
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "cancel")
        }
    }
}
