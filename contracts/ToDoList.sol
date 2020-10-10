pragma solidity ^0.5.0;

//see: https://www.dappuniversity.com/articles/blockchain-app-tutorial

contract TodoList {
    uint16 taskCount = 0;
    
    struct Task {
        uint16 id;
        string content;
        bool completed;
    }
    
    mapping(uint16 => Task) public tasks;
    
    event TaskCreated(uint16 id, string content, bool completed);
    event TaskCompleted(uint16 id, bool completed);
    
    constructor() public {
        createTask("Learn more Solidity");
      }
    
    function createTask(string memory _newTask) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _newTask, false);
        emit TaskCreated(taskCount, _newTask, false);
    }
    
    function toggleCompleted(uint16 _id) public {
        Task memory _task = tasks[_id];
        _task.completed = !_task.completed;
        tasks[_id] = _task;
        emit TaskCompleted(_id, _task.completed);
    }
}
