import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Task } from '../model/task';

@Injectable({
  providedIn: 'root'
})
export class CrudService {
  private serviceURL = "http://localhost:3000"; // Update the URL to your backend server

  constructor(private http: HttpClient) {}

  addTask(task: Task): Observable<Task> {
    return this.http.post<Task>(`${this.serviceURL}/tasks`, task);
  }

  getAllTask(): Observable<Task[]> {
    return this.http.get<Task[]>(`${this.serviceURL}/tasks`);
  }

  deleteTask(task: Task): Observable<Task> {
    return this.http.delete<Task>(`${this.serviceURL}/tasks/${task.id}`);
  }


  completeTask(task: Task): Observable<Task> {
    return this.http.put<Task>(`${this.serviceURL}/tasks/${task.id}`, task);
  }
}
