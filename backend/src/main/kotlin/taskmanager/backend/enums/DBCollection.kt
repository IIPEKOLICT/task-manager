package taskmanager.backend.enums

enum class DBCollection(val collectionName: String, val entityName: String) {
    USER("users", "Пользователь"),
    PROJECT("projects", "Проект"),
    TAG("tags", "Тег"),
    TASK("tasks", "Задача"),
    WORK("works", "Работа"),
    COMMENT("comments", "Комментарий"),
    NOTE("notes", "Заметка"),
    ATTACHMENT("attachments", "Вложение")
}
