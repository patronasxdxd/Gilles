//
//  TODOVIEW.swift
//  Projects
//
//  Created by Gilles Zwijsen on 11/10/2023.
//


import SwiftUI


class TaskViewModel: ObservableObject {
    @Published var todos: [Task] = []
    
    struct API {
        static let baseURL = "http://localhost:3000/tasks"
    }
    
    
    struct Task: Identifiable, Codable {
        let id: Int?
        var task_name: String
        var isDone: Bool = false
    }
    
    
    func getTasksFromServer() {
        guard let url = URL(string: API.baseURL) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching tasks: \(error)")
                return
            }
            
            if let data = data {
                let downloadedTasks = try? JSONDecoder().decode([Task].self, from: data)
                if let downloadedTasks = downloadedTasks {
                    print(downloadedTasks)
                    DispatchQueue.main.async {
                        self?.todos = downloadedTasks
                    }
                } else {
                    print("Error decoding tasks.")
                }
            }
        }.resume()
    }
    
    
    func toggleTaskCompletion(task: Task) {
        guard let taskId = task.id else {
            print("Task ID is nil")
            return
        }
        guard let url = URL(string: "\(API.baseURL)/\(taskId)/complete") else {
              print("Invalid URL")
              return
          }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error while toggling task completion: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data: \(dataString)")
            }
            
            self?.getTasksFromServer() // Refresh tasks
        }.resume()
    }

    
    func postTaskToServer(task: Task) {
        guard let url = URL(string: API.baseURL) else {
              print("Invalid URL")
              return
          }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(task)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.getTasksFromServer()
        }.resume()
    }
    
    func removeTaskToServer(task: Task) {
        guard let taskId = task.id else {
              print("Task ID is nil")
              return
          }
        guard let url = URL(string: "\(API.baseURL)/\(taskId)") else {
             print("Invalid URL")
             return
         }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(task)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error while deleting task: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data: \(dataString)")
            }
            
            self?.getTasksFromServer()
        }.resume()
        
    }}


struct TODOView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Text Field for New Task
            HStack {
                TextField("New Task", text: $newTask, onCommit: {
                    if !newTask.isEmpty {
                        let task = TaskViewModel.Task(id: nil,task_name: newTask)
                        viewModel.postTaskToServer(task: task)
                        newTask = ""
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                Button(action: {
                    if !newTask.isEmpty {
                        let task = TaskViewModel.Task(id: nil,task_name: newTask)
                        viewModel.postTaskToServer(task: task)
                        newTask = ""
                    }
                }) {
                    Text("Add Task")
                        
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            
            List {
                ForEach(viewModel.todos) { task in
                    HStack {
                        Button(action: {
                            if let index = viewModel.todos.firstIndex(where: { $0.id == task.id }) {
                                var updatedTask = viewModel.todos[index]
                                updatedTask.isDone.toggle()
                                viewModel.toggleTaskCompletion(task: task)

                            
                            }
                        }) {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .green : .gray)
                        }
                        
                        Text(task.task_name)
                            .strikethrough(task.isDone)
                            .foregroundColor(task.isDone ? .gray : .primary)
                        
                        Spacer()
                        
                        Button(action: {
                            if let index = viewModel.todos.firstIndex(where: { $0.id == task.id }) {
                                viewModel.removeTaskToServer(task: task)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(InsetListStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.3))
        .navigationTitle("TODO List")
        .onAppear {
            viewModel.getTasksFromServer()
        }
    }
}

struct TODOView_Previews: PreviewProvider {
    static var previews: some View {
        TODOView()
    }
}
