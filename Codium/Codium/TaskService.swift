//
//  TaskService.swift
//  Codium
//
//  Created by Gilles Zwijsen on 19/10/2023.
//

import Foundation


class TaskService {
    
    static let shared = TaskService() // Singleton
    internal init() {}

    struct API {
        static let baseURL = "http://localhost:3000/tasks"
    }

    func getTasksFromServer(completion: @escaping (Result<[Task], Error>) -> Void) {
        guard let url = URL(string: API.baseURL) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching tasks: \(error)")
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let downloadedTasks = try JSONDecoder().decode([Task].self, from: data)
                    print(downloadedTasks)
                    completion(.success(downloadedTasks))
                } catch {
                    print("Error decoding tasks: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func toggleTaskCompletion(task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let taskId = task.id else {
            print("Task ID is nil")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Task ID is nil"])))
            return
        }
        
        guard let url = URL(string: "\(API.baseURL)/\(taskId)/complete") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error while toggling task completion: \(error)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
                        
            completion(.success(()))
        }.resume()
    }
        
    func postTaskToServer(task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: API.baseURL) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(task)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error while posting task: \(error)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
        
            self?.getTasksFromServer { result in
                switch result {
                case .success:
                    completion(.success(()))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func removeTaskFromServer(task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let taskId = task.id else {
            print("Task ID is nil")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Task ID is nil"])))
            return
        }
        
        guard let url = URL(string: "\(API.baseURL)/\(taskId)") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONEncoder().encode(task)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error while deleting task: \(error)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }

            self?.getTasksFromServer { result in
                switch result {
                case .success:
                    completion(.success(()))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
