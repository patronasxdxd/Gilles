//
//  TodoListVIewController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private var todos = [Task]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateEmptyListView()
            }
        }
    }
  
    private let emptyListView: UIView = {
        let view = UIView()
        let button = UIButton(type: .system)
        button.setTitle("Create New To-Do", for: .normal)
        button.addTarget(self, action: #selector(didTapAddItemButton), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.isHidden = true
        return view
    }()
    
    // display the todo items
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoItemCell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.setEditing(true, animated: false)
        tableView.isEditing = true
        title = "To-Do List"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddItemButton))

        view.addSubview(emptyListView)
        emptyListView.frame = view.bounds
        
        updateEmptyListView()
        loadTasks()
    }
    
    func loadTasks() {
           TaskService.shared.getTasksFromServer { [weak self] result in
               switch result {
               case .success(let tasks):
                   self?.todos = tasks

               case .failure(let error):
                   print("Error loading tasks: \(error.localizedDescription)")
               }
           }
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todos.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
          let task = todos[indexPath.row]
          cell.textLabel?.text = task.description
          return cell
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToRemove = todos[indexPath.row]

            TaskService.shared.removeTaskFromServer(task: taskToRemove) { result in
                switch result {
                case .success:
                    print("x")

                case .failure(let error):
                    print("An error occurred while removing the task: \(error.localizedDescription)")
                }
            }
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    @objc private func didTapAddItemButton() {
        let alert = UIAlertController(title: "New To-Do Item", message: "Enter the title of your to-do item", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty else {
                return
            }
            let newTask = Task(id: nil, description: text, isDone: false)

            TaskService.shared.postTaskToServer(task: newTask) { result in
                switch result {
                case .success:
                    self?.loadTasks()
                    
                case .failure(let error):
                    print("Error posting task: \(error.localizedDescription)")
                }
            }
        }))
                present(alert, animated: true)
    }

    private func updateEmptyListView() {
           emptyListView.isHidden = !todos.isEmpty
       }

}
