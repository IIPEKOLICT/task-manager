package taskmanager.backend.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.exceptions.custom.base.BaseException

class ForbiddenException(
    message: String = "Доступ запрещен"
) : BaseException(message, HttpStatusCode.Forbidden)