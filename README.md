# Test project - Products list and cart

Тестовое приложение. Отображение списка товаров с возможностью добавления в корзину

## Первый запуск
### ПО:
- Flutter > 3.0.0 < 3.24.5
- Java jdk 17
### Командная строка:
- flutter pub get (для установки пакетов необходимых для работы приложения)

## Screenshots:
<img src="https://github.com/user-attachments/assets/89ba94f0-e418-468b-a834-e6984ac5a4fe" width="200">
<img src="https://github.com/user-attachments/assets/eeb805e9-5988-4fa7-b8d9-40be807dbe6f" width="200">
<img src="https://github.com/user-attachments/assets/e9da4475-0a38-4f85-beaf-7f9ceefb3eee" width="200">

Рекомендованный редактор кода: `Visual Studio Code`.
- Ветка **main** - код, который является последней рабочей версией приложения.

## Общие требования к коду

Все требования к оформлению кода описаны в [официальной документации](https://dart.dev/guides/language/effective-dart/style) для языка Dart.
Длина строки - 100 символов.

## Структура папок

    CartApp
    ├── README.md               # Информация о проекте.
    │
    |
    └── lib                    
        ├── main.dart           # Функция входа в приложение.
        │
        ├── data                # Сервисы и репозитории для получения моделей данных и их парсинга
        ├── presentation        # Экраны и компоненты, DI, state manager, shared.
            │
            └── utils               # Расширения, константы, helpers, dialogs, необходимые для экранов.

## Архитектура приложения

- Архитектруа - Clean Architecture mini (presentation, data слои).
- State Management - BLoC (cubit).
- Релизация экранов - модель MVVM.
- Навигатор - стандартный навигатор.

## Архитектура экранов

Каждый экран состоит из 3 файлов:

- `{name}_page.dart` - файл верстки экрана. Наследуется от BasePage (который, в свою очередь, наследуется от StatefulWidget).
- `{name}_cubit.dart` - файл, содержащий бизнес логику, обработку событий экрана (обработка нажатия, загрузка данных на страницу, отправка данных и т.д.). Наследуется от BaseCubit (кастомный класс).
- `{name}_state.dart` - файл, содержащий все возможные переменные(states) для экрана.