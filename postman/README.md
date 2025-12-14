Практика 6 — Тестирование и мокирование API в Postman
В рамках данной практической работы был настроен Postman для тестирования API приложения «Умный список задач» (TaskManager), создан мок-сервер и реализованы автоматические тесты запросов.

1. Структура коллекции
В Postman создана коллекция TaskManager API со следующей структурой:

Authentication
POST /auth/login — авторизация пользователя.

Tasks Management
GET /tasks — получение списка задач.

POST /tasks — создание новой задачи.

PATCH /tasks/{id} — обновление задачи.

DELETE /tasks/{id} — удаление задачи.

Categories
GET /categories — получение списка категорий.

Все запросы используют переменную окружения {{base_url}}, что позволяет легко переключаться между реальным API и мок-сервером.

2. Окружения (Environments)
Созданы два окружения.

2.1 Local API
Используется для работы с реальным сервером разработки.

Переменные:

base_url = http://localhost:3000/api
(или другой адрес, указанный преподавателем)

2.2 TaskManager Mock Server
Используется для работы с мок-сервером Postman.

Переменные:

base_url = https://<mock-id>.mock.pstmn.io

URL мок-сервера автоматически сохраняется в окружение при его создании.

Переключение окружений выполняется в правом верхнем углу Postman.

3. Mock Server
На основе коллекции TaskManager API был создан мок-сервер:

Name: TaskManager Mock Server

Collection: TaskManager API

Включён параметр Save the mock server URL as an environment variable

Network delay: No delay

Мок-сервер позволяет тестировать клиентскую часть приложения без запущенного реального бэкенда.

4. Examples (примеры ответов)
Для запросов коллекции созданы Examples, которые используются мок-сервером для возврата заранее определённых ответов.

4.1 POST /auth/login — Login Example
Request:

Method: POST

URL: {{base_url}}/auth/login

Body (JSON):

json
{
  "email": "user@example.com",
  "password": "secret123"
}
Response Example:

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
{
  "token": "mocked-jwt-token-123",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
4.2 GET /tasks — Get All Tasks Example
Response Example:

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
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
4.3 POST /tasks — Create Task Example
Response Example:

Status: 201 Created

Headers: Content-Type: application/json

Body:

json
{
  "id": 3,
  "title": "Купить продукты",
  "description": "Молоко, хлеб, яйца",
  "dueDate": "2025-12-20",
  "priority": "medium",
  "status": "pending"
}
4.4 GET /categories — Get Categories Example
Response Example:

Status: 200 OK

Headers: Content-Type: application/json

Body:

json
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
5. Автоматические тесты (Tests)
Для запросов коллекции реализованы автоматические тесты во вкладке Scripts → Post-response.

Пример тестов для POST /auth/login:
Проверка статуса ответа (200 OK)

Проверка формата ответа (JSON)

Проверка наличия поля token

Проверка наличия объекта user

Все тесты успешно проходят при запуске запросов и коллекции целиком.

6. Запуск коллекции (Collection Runner)
Коллекция TaskManager API была запущена через Postman Collection Runner.

Все запросы выполнены последовательно

Все тесты завершились со статусом PASS

Ошибок выполнения не обнаружено

7. Экспорт коллекции и окружений
В репозиторий добавлены файлы:

TaskManagerAPI.postman_collection.json

LocalAPI.postman_environment.json

MockAPI.postman_environment.json

Импорт выполняется через:

text
File → Import → Upload Files
8. Вывод
В ходе практической работы:

Создана и структурирована коллекция запросов для API TaskManager

Настроены локальное окружение и мок-сервер

Реализованы примеры ответов для мокирования API

Добавлены автоматические тесты запросов

Проверена работоспособность через Collection Runner

Обеспечена воспроизводимость путём экспорта конфигураций

Работа полностью соответствует требованиям практики №6.
