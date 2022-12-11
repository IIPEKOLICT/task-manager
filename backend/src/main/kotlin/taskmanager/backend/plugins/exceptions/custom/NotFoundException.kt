package taskmanager.backend.plugins.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.plugins.exceptions.custom.base.BaseException

class NotFoundException(
    message: String = "Не найдено"
) : BaseException(message, HttpStatusCode.NotFound)