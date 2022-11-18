package taskmanager.backend.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.exceptions.custom.base.BaseException

class UnauthorizedException(
    message: String = "Ошибка авторизации"
) : BaseException(message, HttpStatusCode.Unauthorized)