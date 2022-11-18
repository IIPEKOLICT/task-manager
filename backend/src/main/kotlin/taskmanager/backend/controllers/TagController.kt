package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.dtos.request.*
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.models.Tag
import taskmanager.backend.models.User
import taskmanager.backend.services.TagService

@Controller("tags")
class TagController {

    private val tagService by inject<TagService>(TagService::class.java)

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Tag {
        return tagService.getById(id)
    }

    @Patch("{id}/name")
    @Authentication(["auth-jwt"])
    suspend fun updateName(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("name") name: String
    ): Tag {
        if (!tagService.isOwner(id, user._id)) {
            throw ForbiddenException("Вы не можете изменять этот тег")
        }

        return tagService.updateById(id, name)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        if (!tagService.isOwner(id, user._id)) {
            throw ForbiddenException("Вы не можете удалить этот тег")
        }

        return DeleteDto(tagService.deleteById(id))
    }
}