import { Component, OnInit } from '@angular/core';
import { Task } from 'src/app/model/task';
import { CrudService } from 'src/app/service/crud.service';

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.css']
})
export class TodoComponent implements OnInit {

  taskObject : Task = new Task();
  tasks : Task[] = [];
  task : string = '';

  constructor(private crudService : CrudService) { }

  ngOnInit(): void {
    this.taskObject = new Task();
    this.task = '';
    this.tasks = [];
    this.getAllTask();
  }


  deleteTask(etask : Task) {
    this.crudService.deleteTask(etask).subscribe({
      next: (res) => {
        this.ngOnInit();
      },
      error: (err) => {
        alert("Failed to delete task");
      }
    });
  }

  getAllTask() {
    this.crudService.getAllTask().subscribe({
      next: (res) => {
        console.log(res);
        this.tasks = res;
      },
      error: (err) => {
        alert("please start redis server");
      }
    });
  }
  

  addTask() {
    if (!this.task || this.task.trim() === '') {
      return;
    }
    this.taskObject.task_name = this.task;
    this.crudService.addTask(this.taskObject).subscribe({
      next: (res) => {
        this.ngOnInit();
        this.task = '';
      },
      error: (err) => {
        alert(err);
      }
    });
  }


  completeTask(etask: Task) {
    etask.isDone = !etask.isDone;
    this.crudService.completeTask(etask).subscribe({
      next: (res) => {
        this.ngOnInit();
      },
      error: (err) => {
        alert("Failed to complete task");
      }
    });
  }

}
