package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.*
import taskmanager.backend.dtos.response.CommentResponseDto
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.mappers.CommentMapper
import taskmanager.backend.models.Comment
import taskmanager.backend.models.User
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.CommentService
import taskmanager.backend.services.TaskService

@Controller("comments")
class CommentController(
    private val commentService: CommentService,
    private val taskService: TaskService,
    private val commentMapper: CommentMapper
) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(
        @JwtUser user: User,
        @Param("id") id: String
    ): CommentResponseDto {
        return commentMapper.convert(
            userId = user._id,
            entity = commentService.getById(ObjectId(id))
        )
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.COMMENT, "Вы не можете изменять этот комментарий")
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("text") text: String
    ): CommentResponseDto {
        return commentMapper.convert(
            userId = user._id,
            entity = commentService.updateById(ObjectId(id), text)
        )
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.COMMENT, "Вы не можете удалить этот комментарий")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        val comment: Comment = commentService.getById(ObjectId(id))
        taskService.removeComment(comment.task, comment._id)
        return DeleteDto(commentService.deleteById(comment._id))
    }
}