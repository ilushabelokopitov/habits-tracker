// CI test comment
function addTask() {
    const taskInput = document.getElementById('taskInput');
    const taskText = taskInput.value.trim();
    
    // Проверка, что поле не пустое
    if (!taskText) {
        alert('Введите текст задания!');
        return;
    }
    
    // Создаем новый элемент списка
    const taskList = document.getElementById('taskList');
    const li = document.createElement('li');
    li.innerHTML = `
        <span>${taskText}</span>
        <button onclick="event.stopPropagation(); this.parentElement.remove()">Удалить</button>
    `;
    li.setAttribute('onclick', 'toggleTaskCompletion(this)');
    
    taskList.appendChild(li);
    
    // Очищаем поле ввода и возвращаем фокус
    taskInput.value = '';
    taskInput.focus();
}

function toggleTaskCompletion(element) {
    const taskText = element.querySelector('span');
    taskText.classList.toggle('completed');
}
function deleteTask(button) {
    if (confirm('Вы уверены, что хотите удалить эту задачу?')) {
        button.parentElement.remove();
    }
}
