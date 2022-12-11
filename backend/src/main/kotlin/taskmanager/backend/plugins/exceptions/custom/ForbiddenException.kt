package taskmanager.backend.plugins.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.plugins.exceptions.custom.base.BaseException

class ForbiddenException(
    message: String = "Доступ запрещен"
) : BaseException(message, HttpStatusCode.Forbidden)