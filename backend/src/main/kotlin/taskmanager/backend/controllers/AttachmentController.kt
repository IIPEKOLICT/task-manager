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
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.models.Attachment
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.models.User
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.AttachmentService
import taskmanager.backend.services.TaskService

@Controller("attachments")
class AttachmentController(
    private val attachmentService: AttachmentService,
    private val taskService: TaskService
) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(
        @JwtUser user: User,
        @Param("id") id: String
    ): AttachmentResponseDto {
        return attachmentService.getById(ObjectId(id)).toResponseDto(user._id)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.ATTACHMENT, "Вы не можете удалить это вложение")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        val attachment: Attachment = attachmentService.getById(ObjectId(id))
        taskService.removeAttachment(attachment.task, attachment._id)
        return DeleteDto(attachmentService.deleteById(attachment._id))
    }
}