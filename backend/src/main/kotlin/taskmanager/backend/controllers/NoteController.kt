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
import taskmanager.backend.dtos.response.NoteResponseDto
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.mappers.NoteMapper
import taskmanager.backend.models.User
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.NoteService

@Controller("notes")
class NoteController(
    private val noteService: NoteService,
    private val noteMapper: NoteMapper
) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(
        @JwtUser user: User,
        @Param("id") id: String
    ): NoteResponseDto {
        return noteMapper.convert(
            userId = user._id,
            entity = noteService.getById(ObjectId(id))
        )
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.NOTE, "Вы не можете изменять эту заметку")
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = NoteDto::class) dto: NoteDto
    ): NoteResponseDto {
        return noteMapper.convert(
            userId = user._id,
            entity = noteService.updateById(ObjectId(id), dto)
        )
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.NOTE, "Вы не можете удалить эту заметку")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        return DeleteDto(noteService.deleteById(ObjectId(id)))
    }
}