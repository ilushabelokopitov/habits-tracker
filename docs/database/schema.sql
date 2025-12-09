PRAGMA foreign_keys = ON;

CREATE TABLE Users (
    user_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    username    TEXT NOT NULL UNIQUE,
    email       TEXT NOT NULL UNIQUE,
    created_at  TEXT DEFAULT (datetime('now'))
);

CREATE TABLE Projects (
    project_id  INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    description TEXT,
    created_at  TEXT DEFAULT (datetime('now')),
    user_id     INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    description TEXT,
    created_at  TEXT DEFAULT (datetime('now'))
);

CREATE TABLE Tasks (
    task_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT NOT NULL,
    description TEXT,
    due_date    TEXT,
    priority    TEXT CHECK(priority IN ('low', 'medium', 'high')) DEFAULT 'medium',
    status      TEXT CHECK(status IN ('pending', 'in progress', 'completed')) DEFAULT 'pending',
    created_at  TEXT DEFAULT (datetime('now')),
    updated_at  TEXT DEFAULT (datetime('now')),
    user_id     INTEGER NOT NULL,
    project_id  INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE SET NULL
);

CREATE TABLE Task_Categories (
    task_id     INTEGER,
    category_id INTEGER,
    assigned_at TEXT DEFAULT (datetime('now')),
    PRIMARY KEY (task_id, category_id),
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

CREATE INDEX idx_tasks_user_id ON Tasks(user_id);
CREATE INDEX idx_tasks_project_id ON Tasks(project_id);
CREATE INDEX idx_project_user_id ON Projects(user_id);
CREATE INDEX idx_task_cat_task ON Task_Categories(task_id);
CREATE INDEX idx_task_cat_category ON Task_Categories(category_id);
