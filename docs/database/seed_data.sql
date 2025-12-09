INSERT INTO Users (username, email) VALUES
('alex_ivanov', 'alex@example.com'),
('maria_petrova', 'maria@example.com');

INSERT INTO Projects (name, description, user_id) VALUES
('Работа', 'Проекты по работе', 1),
('Личное', 'Личные задачи и дела', 2);

INSERT INTO Categories (name, description) VALUES
('Срочное', 'Требует немедленного внимания'),
('Важно', 'Высокий приоритет'),
('Можно потом', 'Низкий приоритет');

INSERT INTO Tasks (title, description, due_date, priority, status, user_id, project_id) VALUES
('Закрыть отчёт', 'Отчёт по проекту', '2024-12-20', 'high', 'pending', 1, 1),
('Сходить в магазин', 'Купить продукты', '2024-12-10', 'medium', 'pending', 2, 2),
('Убраться дома', 'Навести порядок', '2024-12-12', 'low', 'in progress', 2, 2);

INSERT INTO Task_Categories (task_id, category_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 2);
