package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.*
import taskmanager.backend.dtos.response.AttachmentResponseDto
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.models.User
import taskmanager.backend.services.AttachmentService

@Controller("attachments")
class AttachmentController(private val attachmentService: AttachmentService) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): AttachmentResponseDto {
        return attachmentService.getById(ObjectId(id)).toResponseDto()
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val attachment = attachmentService.getById(ObjectId(id))

        if (!attachmentService.isOwner(attachment, user._id)) {
            throw ForbiddenException("Вы не можете удалить это вложение")
        }

        return DeleteDto(attachmentService.deleteById(attachment._id))
    }
}