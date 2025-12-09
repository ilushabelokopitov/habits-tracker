# Habits Tracker / Умный список задач

Учебный проект для дисциплины по проектированию и моделированию программных систем.  
Приложение моделирует работу "умного списка задач" (task manager / habits tracker).

Репозиторий используется для выполнения лабораторных работ:

- проектирование базы данных (ER-диаграмма, нормализация, DDL)
- моделирование поведения (Use Case и диаграммы последовательности)

---

## Функциональность (модель системы)

Основные сценарии использования приложения:

- добавление новой задачи  
- пометка задачи как выполненной  
- редактирование задачи  
- удаление задачи  
- просмотр списка задач  
- фильтрация задач по категориям  
- поиск задач  
- сортировка задач  

Эти сценарии отражены в Use Case диаграмме и диаграммах последовательности.

---

## Структура репозитория

```text
docs/
  database/
    er-diagram.png        # ER-диаграмма базы данных (PNG)
    er-diagram.svg        # ER-диаграмма базы данных (SVG)

  use-case/
    use-case.puml         # PlantUML-код Use Case диаграммы
    use-case.png          # Use Case диаграмма (PNG)
    use-case.svg          # Use Case диаграмма (SVG)
    scenarios.md          # Описание основных сценариев

  behavior/
    sequence/
      add-task-sequence.puml        # Sequence: добавление задачи (код)
      add-task-sequence.png         # Sequence: добавление задачи (PNG)
      add-task-sequence.svg         # Sequence: добавление задачи (SVG)

      complete-task-sequence.puml   # Sequence: отметка задачи выполненной (код)
      complete-task-sequence.png    # Sequence: отметка задачи выполненной (PNG)
      complete-task-sequence.svg    # Sequence: отметка задачи выполненной (SVG)

      filter-tasks-sequence.puml    # Sequence: фильтрация задач по категории (код)
      filter-tasks-sequence.png     # Sequence: фильтрация задач по категории (PNG)
      filter-tasks-sequence.svg     # Sequence: фильтрация задач по категории (SVG)

database/
  schema.sql        # Нормализованная схема БД (SQLite, 3NF)
  seed_data.sql     # Тестовые данные для базы

.github/
  ...               # CI / workflow (если настроены)
