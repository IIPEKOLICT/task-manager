package taskmanager.backend.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.exceptions.custom.base.BaseException

class InternalServerException(
    message: String = "Неизвестная ошибка"
) : BaseException(message, HttpStatusCode.InternalServerError)