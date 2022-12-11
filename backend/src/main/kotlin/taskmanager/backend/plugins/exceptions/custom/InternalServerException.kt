package taskmanager.backend.plugins.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.plugins.exceptions.custom.base.BaseException

class InternalServerException(
    message: String = "Неизвестная ошибка"
) : BaseException(message, HttpStatusCode.InternalServerError)