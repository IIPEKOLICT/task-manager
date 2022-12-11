package taskmanager.backend.plugins.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.plugins.exceptions.custom.base.BaseException

class UnauthorizedException(
    message: String = "Ошибка авторизации"
) : BaseException(message, HttpStatusCode.Unauthorized)