
# Практика 6 — Тестирование и мокирование API в Postman

В этой работе настроен Postman для тестирования API приложения **"Умный список задач" / TaskManager** и создан мок-сервер для имитации ответов бэкенда.

## 1. Структура коллекции

Создана коллекция **TaskManager API** со следующими папками и запросами:

- **Authentication**
  - `POST /auth/login` — логин пользователя.

- **Tasks Management**
  - `GET /tasks` — получить список задач.
  - `POST /tasks` — создать задачу.
  - `PATCH /tasks/{id}` — обновить задачу.
  - `DELETE /tasks/{id}` — удалить задачу.

- **Categories**
  - `GET /categories` — получить список категорий.

Все запросы используют переменную окружения `{{base_url}}`, чтобы легко переключаться между реальным API и мок-сервером.

---

## 2. Окружения (Environments)

Созданы два окружения:

### 2.1 Local API

Используется для работы с реальным сервером разработки.

- **Variable:**  
  - `base_url = http://localhost:3000/api`  
    (или другой URL, указанный преподавателем)

### 2.2 TaskManager Mock Server

Используется для запросов к мок-серверу Postman.

- **Variable:**  
  - `base_url = https://<mock-id>.mock.pstmn.io`  
    (URL автоматически подставляется при создании Mock Server)

Выбор окружения осуществляется в правом верхнем углу Postman:
**Environment → Local API / TaskManager Mock Server**.

---

## 3. Mock Server

На основе коллекции **TaskManager API** создан мок-сервер:

- Name: **TaskManager Mock Server**
- Collection: **TaskManager API**
- Флаг *“Save the mock server URL as an environment variable”* включён — URL мок-сервера сохранён в окружении `TaskManager Mock Server` в переменную `base_url`.
- Network delay: **No delay** (ответы приходят сразу).

Mock Server позволяет тестировать работу клиента без запущенного реального бэкенда.

---

## 4. Examples (примеры ответов)

Для основных запросов коллекции созданы **Examples**, которые определяют, какой ответ будет отдавать мок-сервер.

### 4.1 POST /auth/login — Login Example

- **Request**  
  - Method: `POST`  
  - URL: `{{base_url}}/auth/login`  
  - Body (JSON):

    ```json
    {
      "email": "user@example.com",
      "password": "secret123"
    }
    ```

- **Response Example**
  - Status: `200 OK`
  - Headers: `Content-Type: application/json`
  - Body:

    ```json
    {
      "token": "mocked-jwt-token-123",
      "user": {
        "id": 1,
        "email": "user@example.com"
      }
    }
    ```

---

### 4.2 GET /tasks — Get All Tasks Example

- **Response Example**
  - Status: `200 OK`
  - Headers: `Content-Type: application/json`
  - Body:

    ```json
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
    ```

---

### 4.3 POST /tasks — Create Task Example

- **Response Example**
  - Status: `201 Created`
  - Headers: `Content-Type: application/json`
  - Body:

    ```json
    {
      "id": 3,
      "title": "Купить продукты",
      "description": "Молоко, хлеб, яйца",
      "dueDate": "2025-12-20",
      "priority": "medium",
      "status": "pending"
    }
    ```

---

### 4.4 GET /categories — Get Categories Example

- **Response Example**
  - Status: `200 OK`
  - Headers: `Content-Type: application/json`
  - Body:

    ```json
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
    ```

---

## 5. Проверка работы мок-сервера

1. В правом верхнем углу выбрать окружение **TaskManager Mock Server**.
2. Открыть запрос `POST /auth/login` и нажать **Send**.  
   В ответ должен прийти JSON с полями `token` и `user` из Login Example.
3. Открыть `GET /tasks` → **Send**.  
   В ответ — список задач из соответствующего примера.
4. Аналогично проверить `POST /tasks` и `GET /categories`.

---

## 6. Экспорт коллекции и окружений

В репозиторий добавлены JSON-файлы:

- Коллекция Postman:
  - `TaskManagerAPI.postman_collection.json`
- Окружения:
  - `LocalAPI.postman_environment.json`
  - `MockAPI.postman_environment.json`

Их можно импортировать в Postman через:

> **File → Import → Upload Files**

---

## 7. Вывод

В рамках практики:

- Спроектирована и реализована коллекция запросов для API “Умного списка задач”.
- Настроены два окружения (локальное и мок-сервер).
- Создан Mock Server в Postman и настроены примеры ответов для ключевых запросов.
- Продемонстрирована возможность тестировать клиентскую часть приложения без реального бэкенда за счёт мок-ответов.

