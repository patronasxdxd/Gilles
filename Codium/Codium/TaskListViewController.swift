//
//  TaskListViewController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//
import UIKit


class TaskListViewController: UITableViewController {
    
    var tasks = [Task(id: 1,description: "Task 1", isDone: false), Task(id:2,description: "Task 2", isDone: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        self.title = "To-Do List"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        // Configure the cell...
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.description
        cell.accessoryType = task.isDone ? .checkmark : .none

        return cell
    }
    
    // Updating the status of a task when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].isDone.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
