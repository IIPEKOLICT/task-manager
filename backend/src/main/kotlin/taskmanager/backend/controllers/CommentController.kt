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
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.models.Comment
import taskmanager.backend.models.User
import taskmanager.backend.services.CommentService

@Controller("comments")
class CommentController(private val commentService: CommentService) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Comment {
        return commentService.getById(ObjectId(id))
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("text") text: String
    ): Comment {
        val objectId = ObjectId(id)

        if (!commentService.isOwner(commentService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете изменять этот комментарий")
        }

        return commentService.updateById(objectId, text)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val objectId = ObjectId(id)

        if (!commentService.isOwner(commentService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете удалить этот комментарий")
        }

        return DeleteDto(commentService.deleteById(objectId))
    }
}