## TODO Service - Микросервис на базе FastAPI

### Описание проекта
Это микросервис для управления задачами (TODO-лист), построенный на FastAPI с использованием SQLite в качестве базы данных. 
Сервис предоставляет полный набор CRUD-операций и упакован в Docker-контейнер для удобства развертывания.

Основные возможности:
* Создание, чтение, обновление и удаление задач
* Автоматическая генерация документации API через Swagger UI и ReDoc
* Хранение данных в SQLite с гарантированным сохранением при перезапуске контейнера
* Полная контейнеризация с использованием Docker и Docker Compose
* Использование Docker volumes для надежного хранения данных

### Быстрый запуск

#### Способ 1: Использование Docker Compose (рекомендуется)
Убедитесь, что у вас установлены Docker Desktop для пользователей Windows / Docker и Docker Compose для пользователей Linux/macOS. 
Затем выполните:
- docker-compose up -d
Эта команда автоматически соберет образ и запустит контейнер. 
Сервис будет доступен по адресу http://localhost:8000

#### Способ 2: Ручной запуск через Docker
Выполнение команд Docker напрямую:
- docker build -t todo-service:latest .
- docker volume create todo_data
- docker run --rm -p 8000:80 \
-v todo_data:/app/data \
todo-service:local

#### Способ 3: Локальный запуск для разработки
- python -m venv venv

##### Активация окружения
На Linux/Mac:
- source venv/bin/activate
На Windows:
- venv\Scripts\activate

##### Установка зависимостей
- pip install -r requirements.txt

##### Запуск сервиса
- uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

### Доступ к API
После успешного запуска сервис предоставляет следующие эндпоинты:
* Документация Swagger UI: http://localhost:8000/docs
* Создание задачи: POST http://localhost:8000/items
* Получение всех задач: GET http://localhost:8000/items
* Получение задачи по ID: GET http://localhost:8000/items/{id}
* Обновление задачи: PUT http://localhost:8000/items/{id}
* Удаление задачи: DELETE http://localhost:8000/items/{id}

### Сохранение данных
Данный сервис поддерживает сохранение данных между перезапусками контейнера. 
Это достигается за счет использования Docker volume. 
Все данные хранятся в файле SQLite, который находится в volume с именем todo_data.

### Структура проекта
Проект имеет следующую структуру:
* Dockerfile: конфигурация для сборки Docker образа
* docker-compose.yml: конфигурация для запуска через Docker Compose
* requirements.txt: зависимости Python
* app/main.py: основной файл FastAPI приложения
* app/db.py: работа с базой данных SQLite
* app/schemas.py: схемы данных для валидации

### Настройка
При необходимости сервис может быть настроен через переменные окружения:
* DATA_DIR - директория для хранения данных (по умолчанию /app/data)
* DB_PATH - путь к файлу базы данных (по умолчанию /app/data/todo.db)

Чтобы изменить порт, на котором работает сервис, отредактируйте файл docker-compose.yml 
или используйте другой порт при запуске через docker run.
