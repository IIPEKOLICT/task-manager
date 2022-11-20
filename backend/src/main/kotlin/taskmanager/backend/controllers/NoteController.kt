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
import taskmanager.backend.models.Note
import taskmanager.backend.models.User
import taskmanager.backend.services.NoteService

@Controller("notes")
class NoteController(private val noteService: NoteService) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Note {
        return noteService.getById(ObjectId(id))
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = NoteDto::class) dto: NoteDto
    ): Note {
        val objectId = ObjectId(id)

        if (!noteService.isOwner(noteService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете изменять эту заметку")
        }

        return noteService.updateById(objectId, dto)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val objectId = ObjectId(id)

        if (!noteService.isOwner(noteService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете удалить эту заметку")
        }

        return DeleteDto(noteService.deleteById(objectId))
    }
}