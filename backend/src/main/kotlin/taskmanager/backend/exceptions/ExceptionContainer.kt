package taskmanager.backend.exceptions

import com.github.iipekolict.knest.annotations.methods.DefaultExceptionHandler
import com.github.iipekolict.knest.annotations.methods.ExceptionHandler
import com.github.iipekolict.knest.annotations.properties.Call
import com.github.iipekolict.knest.annotations.properties.Exc
import com.github.iipekolict.knest.exceptions.KNestException
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import taskmanager.backend.dtos.response.ExceptionResponseDto
import taskmanager.backend.exceptions.custom.*
import taskmanager.backend.exceptions.custom.NotFoundException

object ExceptionContainer {

    @DefaultExceptionHandler
    suspend fun defaultExceptionHandler(@Call call: ApplicationCall, @Exc exception: Exception) {
        call.respond(
            status = HttpStatusCode.InternalServerError,
            message = ExceptionResponseDto(
                code = HttpStatusCode.InternalServerError.value,
                message = exception.message ?: "Неизвестная ошибка"
            )
        )
    }

    @ExceptionHandler(KNestException::class)
    suspend fun kNestExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: KNestException
    ) {
        call.respond(
            status = HttpStatusCode.InternalServerError,
            message = ExceptionResponseDto(
                code = HttpStatusCode.InternalServerError.value,
                message = exception.message
            )
        )
    }

    @ExceptionHandler(AWSException::class)
    suspend fun awsExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: AWSException
    ) {
        call.respond(
            status = HttpStatusCode.ServiceUnavailable,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(ForbiddenException::class)
    suspend fun forbiddenExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: ForbiddenException
    ) {
        call.respond(
            status = HttpStatusCode.Forbidden,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(InternalServerException::class)
    suspend fun internalServerExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: InternalServerException
    ) {
        call.respond(
            status = HttpStatusCode.InternalServerError,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(NotFoundException::class)
    suspend fun notFoundExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: NotFoundException
    ) {
        call.respond(
            status = HttpStatusCode.NotFound,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(UnauthorizedException::class)
    suspend fun unauthorizedExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: UnauthorizedException
    ) {
        call.respond(
            status = HttpStatusCode.Unauthorized,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(EntityNotFoundException::class)
    suspend fun entityNotFoundExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: EntityNotFoundException
    ) {
        call.respond(
            status = HttpStatusCode.BadRequest,
            message = exception.toResponseDto()
        )
    }

    @ExceptionHandler(BadRequestException::class)
    suspend fun badRequestExceptionHandler(
        @Call call: ApplicationCall,
        @Exc exception: BadRequestException
    ) {
        call.respond(
            status = HttpStatusCode.BadRequest,
            message = ExceptionResponseDto(
                code = HttpStatusCode.BadRequest.value,
                message = exception.message ?: "Параметры запроса не верны"
            )
        )
    }
}