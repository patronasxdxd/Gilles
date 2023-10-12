const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

app.use(bodyParser.json());
app.use(cors());

const tasks = [];

app.get('/tasks', (req, res) => {
  res.json(tasks);
});

let taskIdCounter = 1; // Initialize a counter for generating task IDs

app.post('/tasks', (req, res) => {
  const newTask = req.body;
  newTask.id = taskIdCounter++; 
  tasks.push(newTask);
  res.json(newTask);
});


app.put('/tasks/:id', (req, res) => {
  const taskId = req.params.id;
  const updatedTask = req.body;
  const taskIndex = tasks.findIndex((task) => task.id === parseInt(taskId)); // parsed it as an integer
  if (taskIndex !== -1) {
    tasks[taskIndex] = updatedTask;
    res.json(updatedTask);
  } else {
    res.status(404).json({ error: 'Task not found' });
  }
});

app.delete('/tasks/:id', (req, res) => {
    const taskId = req.params.id;
    const taskIndex = tasks.findIndex((task) => task.id === parseInt(taskId)); // parsed it as an integer
  
    if (taskIndex !== -1) {
      const deletedTask = tasks.splice(taskIndex, 1)[0];
      res.json(deletedTask);
    } else {
      console.error(`Task with ID ${taskId} not found.`);
      res.status(404).json({ error: 'Task not found' });
    }
  });


  app.put('/tasks/:id/complete', (req, res) => {
    const taskId = req.params.id;
    const taskIndex = tasks.findIndex((task) => task.id === parseInt(taskId));
    
    if (taskIndex !== -1) {
      tasks[taskIndex].isDone = !tasks[taskIndex].isDone;  
      res.json(tasks[taskIndex]);
    } else {
      res.status(404).json({ error: 'Task not found' });
    }
  });
  

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
