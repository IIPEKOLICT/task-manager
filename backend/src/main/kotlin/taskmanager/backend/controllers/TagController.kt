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
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.models.Tag
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.TagService

@Controller("tags")
class TagController(private val tagService: TagService) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Tag {
        return tagService.getById(ObjectId(id))
    }

    @Patch("{id}/name")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.TAG, "Вы не можете изменять этот тег")
    suspend fun updateName(
        @Param("id") id: String,
        @Body("name") name: String
    ): Tag {
        return tagService.updateById(ObjectId(id), name)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.TAG, "Вы не можете удалить этот тег")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        return DeleteDto(tagService.deleteById(ObjectId(id)))
    }
}