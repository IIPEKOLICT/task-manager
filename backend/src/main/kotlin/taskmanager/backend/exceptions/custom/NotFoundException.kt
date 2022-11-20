package taskmanager.backend.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.exceptions.custom.base.BaseException

class NotFoundException(
    message: String = "Не найдено"
) : BaseException(message, HttpStatusCode.NotFound)