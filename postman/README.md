# Практика 6 — Тестирование и мокирование API в Postman

В данной работе выполнена настройка Postman для тестирования API приложения **TaskManager (Умный список задач)**, а также реализован Mock Server для имитации ответов бэкенда без запуска реального сервера.

---

## 1. Структура коллекции

Создана коллекция **TaskManager API**, содержащая следующие папки и методы:

### Authentication
- `POST /auth/login` — авторизация пользователя

### Tasks Management
- `GET /tasks` — получение списка задач
- `POST /tasks` — создание задачи
- `PATCH /tasks/{id}` — обновление задачи
- `DELETE /tasks/{id}` — удаление задачи

### Categories
- `GET /categories` — получение списка категорий

Все запросы используют переменную окружения `{{base_url}}`.

---

## 2. Окружения (Environments)

Созданы два окружения:

### 2.1 Local API
Используется для работы с реальным сервером.

Переменная:
- `base_url = http://localhost:3000/api`

---

### 2.2 TaskManager Mock Server
Используется для работы с мок-сервером Postman.

Переменная:
- `base_url = https://<mock-id>.mock.pstmn.io`

Переключение окружений осуществляется в правом верхнем углу Postman.

---

## 3. Mock Server

Создан Mock Server на основе коллекции **TaskManager API**.

Параметры:
- Collection: TaskManager API
- Save mock server URL as environment variable — включено
- Network delay — отсутствует

Mock Server позволяет тестировать API без реального бэкенда.

---

## 4. Examples (примеры ответов)

Для каждого метода созданы **несколько Examples** (успешные и негативные сценарии).  
Выбор ответа осуществляется через query-параметр `scenario`.

---

## 5. Как вызвать негативный ответ (Error/Negative Response)

Чтобы получить **негативный ответ** от Mock Server:

1. В правом верхнем углу Postman выбрать окружение **TaskManager Mock Server**.
2. Открыть нужный запрос из коллекции.
3. В URL добавить соответствующий `scenario`, который привязан к негативному Example.
4. Нажать **Send** — Mock Server вернёт ответ из нужного негативного Example.

Примеры вызова негативных сценариев:

- **Login (ошибка авторизации):**
POST {{base_url}}/auth/login?scenario=invalid

css
Копировать код
Body:
```json
{
  "email": "wrong@example.com",
  "password": "wrong"
}
```
Ожидаемый ответ: 401 Unauthorized, {"message":"Invalid credentials"}

Create Task (ошибка валидации):

```bash
POST {{base_url}}/tasks?scenario=validation
```
Body (без title):

```json
{
  "priority": "medium"
}
```
Ожидаемый ответ: 400 Bad Request, {"message":"Title is required"}

Update Task (задача не найдена):

```bash
PATCH {{base_url}}/tasks/9999?scenario=notfound
```
Ожидаемый ответ: 404 Not Found, {"message":"Task not found"}

Delete Task (задача не найдена):

```bash
DELETE {{base_url}}/tasks/9999?scenario=notfound
```
Ожидаемый ответ: 404 Not Found, {"message":"Task not found"}

Get All Tasks (пустой список):

```bash
GET {{base_url}}/tasks?scenario=empty
```
Ожидаемый ответ: 200 OK, []

Get Categories (пустой список):

```bash
Копировать код
GET {{base_url}}/categories?scenario=empty
```
Ожидаемый ответ: 200 OK, []

6. Examples (детализация ответов)
6.1 POST /auth/login — Login
6.1.1 Example: Login — Success
Request

```bash
Копировать код
POST {{base_url}}/auth/login
```
```json
{
  "email": "user@example.com",
  "password": "secret123"
}
```
Response

Status: 200 OK

```json
{
  "token": "mocked-jwt-token-123",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```
6.1.2 Example: Login — Invalid credentials
Request

```bash
Копировать код
POST {{base_url}}/auth/login?scenario=invalid ```
```json

{
  "email": "wrong@example.com",
  "password": "wrong"
}
```
Response

Status: 401 Unauthorized

```json
{
  "message": "Invalid credentials"
}
```
6.2 GET /tasks — Get All Tasks
6.2.1 Example: Get All Tasks — With items
```bash
Копировать код
GET {{base_url}}/tasks?scenario=items
```
```json
[
  {
    "id": 1,
    "title": "Купить продукты",
    "priority": "medium",
    "status": "pending"
  }
]
```
6.2.2 Example: Get All Tasks — Empty list
```bash
Копировать код
GET {{base_url}}/tasks?scenario=empty
```
```json
[]
```
6.3 POST /tasks — Create Task
6.3.1 Example: Create Task — Success
```bash
Копировать код
POST {{base_url}}/tasks?scenario=success
```
```json
{
  "title": "Купить продукты",
  "priority": "medium"
}
```
Response: 201 Created

6.3.2 Example: Create Task — Validation error
```bash
Копировать код
POST {{base_url}}/tasks?scenario=validation
```
```json
{
  "priority": "medium"
}
```
Response: 400 Bad Request

```json
{
  "message": "Title is required"
}
```
6.4 PATCH /tasks/{id} — Update Task
6.4.1 Example: Update Task — Success
```bash
Копировать код
PATCH {{base_url}}/tasks/1?scenario=success
```
```json 
{
  "status": "in_progress"
}
```
6.4.2 Example: Update Task — Not found
```bash
Копировать код
PATCH {{base_url}}/tasks/9999?scenario=notfound
```
```json
{
  "message": "Task not found"
}
```
6.5 DELETE /tasks/{id} — Delete Task
6.5.1 Example: Delete Task — Success
```bash
Копировать код
DELETE {{base_url}}/tasks/1?scenario=success
```
Response: 204 No Content

6.5.2 Example: Delete Task — Not found
```bash
Копировать код
DELETE {{base_url}}/tasks/9999?scenario=notfound
```
```json
{
  "message": "Task not found"
}
```
6.6 GET /categories — Get Categories
6.6.1 Example: Get Categories — With items
```bash
Копировать код
GET {{base_url}}/categories?scenario=items
```
```json 
[
  { "id": 1, "name": "Работа" },
  { "id": 2, "name": "Личное" }
]
```
6.6.2 Example: Get Categories — Empty list
```bash
Копировать код
GET {{base_url}}/categories?scenario=empty
```
```json
[]
```
7. Автоматические тесты
Для всех методов добавлены тесты во вкладке Scripts → Post-response, проверяющие:

корректность статус-кодов

формат JSON

структуру ответов

соответствие данных выбранному сценарию

8. Запуск коллекции
Коллекция была запущена через Collection Runner.
Все запросы выполнились успешно, тесты завершились со статусом PASS.

9. Экспорт данных
В репозиторий добавлены файлы:

TaskManagerAPI.postman_collection.json

LocalAPI.postman_environment.json

TaskManager Mock Server.postman_environment.json

10. Вывод
В рамках практической работы:

создана Postman-коллекция для API TaskManager

реализованы успешные и негативные сценарии через Mock Server

добавлены автоматические тесты

обеспечена возможность тестирования без реального бэкенда
