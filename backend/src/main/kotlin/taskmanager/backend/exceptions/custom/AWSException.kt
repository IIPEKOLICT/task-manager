package taskmanager.backend.exceptions.custom

import io.ktor.http.*
import taskmanager.backend.exceptions.custom.base.BaseException

class AWSException(
    message: String = "Ошибка на AWS"
) : BaseException(message, HttpStatusCode.ServiceUnavailable)