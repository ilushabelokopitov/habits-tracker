# Практика 6 — Тестирование и мокирование API в Postman

В рамках данной практической работы был настроен **Postman** для тестирования API приложения **«Умный список задач / TaskManager»**, создан **Mock Server**, добавлены **Examples (примеры ответов)** и написаны **автотесты** для запросов.

---

## 1. Структура коллекции

В Postman создана коллекция **TaskManager API** со следующей структурой:

### Authentication
- **POST /auth/login** — авторизация пользователя.

### Tasks Management
- **GET /tasks** — получение списка задач.
- **POST /tasks** — создание новой задачи.
- **PATCH /tasks/{id}** — обновление задачи.
- **DELETE /tasks/{id}** — удаление задачи.

### Categories
- **GET /categories** — получение списка категорий.

Все запросы используют переменную окружения `{{base_url}}`, что позволяет легко переключаться между реальным API и мок-сервером.

---

## 2. Окружения (Environments)

Созданы два окружения.

### 2.1 Local API

Используется для работы с реальным сервером разработки.

- **Variable:**  
  - `base_url = http://localhost:3000/api`  
  *(или другой URL, указанный преподавателем)*

### 2.2 TaskManager Mock Server

Используется для работы с мок-сервером Postman.

- **Variable:**  
  - `base_url = https://<mock-id>.mock.pstmn.io`  
  *(URL автоматически подставляется при создании Mock Server)*

Выбор окружения осуществляется в правом верхнем углу Postman:  
**Environment → Local API / TaskManager Mock Server**

---

## 3. Mock Server

На основе коллекции **TaskManager API** создан мок-сервер:

- **Name:** TaskManager Mock Server  
- **Collection:** TaskManager API  
- Включён флаг **“Save the mock server URL as an environment variable”** — URL сохранён в окружении `TaskManager Mock Server` в переменную `base_url`
- **Network delay:** No delay (ответы приходят сразу)

Mock Server позволяет тестировать работу клиента без запущенного реального бэкенда.

---

## 4. Examples (примеры ответов)

Для каждого метода созданы **примеры ответов (Examples)**.  
Также для нескольких методов добавлено **более одного варианта ответа** (например success / error).

---

### 4.1 POST /auth/login — Login

#### 4.1.1 Example: Login (Success)

- **Request**
  - Method: `POST`
  - URL: `{{base_url}}/auth/login`
  - Body (JSON):


{
  "email": "user@example.com",
  "password": "secret123"
}

- Response Example

- Status: 200 OK

- Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "token": "mocked-jwt-token-123",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
#### 4.1.2 Example: Login — Invalid credentials
Request

Method: POST

URL: {{base_url}}/auth/login

Body (JSON):

json
Копировать код
{
  "email": "wrong@example.com",
  "password": "wrong"
}
Response Example

Status: 401 Unauthorized

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "message": "Invalid credentials"
}
### 4.2 GET /tasks — Get All Tasks
#### 4.2.1 Example: Get All Tasks — With items
Response Example

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
Копировать код
[
  {
    "id": 1,
    "title": "Купить продукты",
    "description": "Молоко, хлеб, яйца",
    "dueDate": "2025-12-20",
    "priority": "medium",
    "status": "pending"
  },
  {
    "id": 2,
    "title": "Сделать домашку по БД",
    "description": "Лаба по нормализации",
    "dueDate": "2025-12-22",
    "priority": "high",
    "status": "in_progress"
  }
]
#### 4.2.2 Example: Get All Tasks — Empty list
Response Example

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
Копировать код
[]
### 4.3 POST /tasks — Create Task
#### 4.3.1 Example: Create Task — Success
Request

Method: POST

URL: {{base_url}}/tasks

Body (JSON):

json
Копировать код
{
  "title": "Купить продукты",
  "description": "Молоко, хлеб, яйца",
  "dueDate": "2025-12-20",
  "priority": "medium"
}
Response Example

Status: 201 Created

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "id": 3,
  "title": "Купить продукты",
  "description": "Молоко, хлеб, яйца",
  "dueDate": "2025-12-20",
  "priority": "medium",
  "status": "pending"
}
4.3.2 Example: Create Task — Validation error
Request

Method: POST

URL: {{base_url}}/tasks

Body (JSON):

json
Копировать код
{
  "description": "Молоко, хлеб, яйца",
  "dueDate": "2025-12-20",
  "priority": "medium"
}
Response Example

Status: 400 Bad Request

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "message": "Title is required"
}
### 4.4 PATCH /tasks/{id} — Update Task
#### 4.4.1 Example: Update Task (Success)
Request

Method: PATCH

URL: {{base_url}}/tasks/1

Body (JSON):

json
Копировать код
{
  "status": "in_progress"
}
Response Example

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "id": 1,
  "title": "Купить продукты",
  "description": "Молоко, хлеб, яйца",
  "dueDate": "2025-12-20",
  "priority": "medium",
  "status": "in_progress"
}
#### 4.4.2 Example: Update Task — Not found
Request

Method: PATCH

URL: {{base_url}}/tasks/9999

Body (JSON):

json
Копировать код
{
  "status": "done"
}
Response Example

Status: 404 Not Found

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "message": "Task not found"
}
### 4.5 DELETE /tasks/{id} — Delete Task
#### 4.5.1 Example: Delete Task — Success
Request

Method: DELETE

URL: {{base_url}}/tasks/1

Response Example

Status: 204 No Content

#### 4.5.2 Example: Delete Task — Not found
Request

Method: DELETE

URL: {{base_url}}/tasks/9999

Response Example

Status: 404 Not Found

Headers: Content-Type: application/json

Body:

json
Копировать код
{
  "message": "Task not found"
}
### 4.6 GET /categories — Get Categories
#### 4.6.1 Example: Get Categories
Response Example

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
Копировать код
[
  {
    "id": 1,
    "name": "Работа"
  },
  {
    "id": 2,
    "name": "Личное"
  },
  {
    "id": 3,
    "name": "Учёба"
  }
]
## 5. Автоматические тесты (Tests)
Для запросов коллекции добавлены тесты во вкладке Scripts → Post-response.

Примеры проверок:

статус-код ответа (200 / 201 / 204 / 400 / 401 / 404)

что ответ является JSON (если ожидается JSON)

наличие ключевых полей (token, user, id, и т.д.)

проверки типа данных (например token — строка)

## 6. Проверка работы мок-сервера
В Postman выбрать окружение TaskManager Mock Server.

Проверить POST /auth/login → Send — должен вернуться ответ из Example.

Проверить GET /tasks → Send — должен вернуться список задач (или пустой список).

Проверить POST /tasks → Send — должен вернуться ответ 201 Created или 400 Bad Request.

Аналогично проверить PATCH /tasks/{id}, DELETE /tasks/{id}, GET /categories.

## 7. Запуск коллекции (Runner)
Коллекция была запущена через Collection Runner.
Результат: все запросы выполнились, тесты завершились статусом PASS.

## 8. Экспорт коллекции и окружений
В репозиторий добавлены JSON-файлы:

Коллекция:

TaskManagerAPI.postman_collection.json

Окружения:

LocalAPI.postman_environment.json

MockAPI.postman_environment.json

Импорт в Postman:

File → Import → Upload Files

## 9. Вывод
В рамках практической работы:

создана коллекция запросов для API TaskManager;

настроены окружения (локальное и мок-сервер);

создан Mock Server и настроены Examples для всех методов;

для части методов сделано несколько вариантов ответа (success/error);

добавлены автоматические тесты и выполнен запуск через Runner.

Работа соответствует требованиям практики №6.
