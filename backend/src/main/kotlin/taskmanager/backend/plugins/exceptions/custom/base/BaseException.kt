package taskmanager.backend.plugins.exceptions.custom.base

import io.ktor.http.*
import taskmanager.backend.dtos.response.ExceptionResponseDto

abstract class BaseException(
    override val message: String = "",
    val statusCode: HttpStatusCode = HttpStatusCode.InternalServerError
): RuntimeException(message) {

    fun toResponseDto(): ExceptionResponseDto {
        return ExceptionResponseDto(statusCode.value, message)
    }
}