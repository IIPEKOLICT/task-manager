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
import taskmanager.backend.models.User
import taskmanager.backend.models.Work
import taskmanager.backend.services.WorkService

@Controller("works")
class WorkController(private val workService: WorkService) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Work {
        return workService.getById(ObjectId(id))
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = WorkDto::class) dto: WorkDto
    ): Work {
        val objectId = ObjectId(id)

        if (!workService.isOwner(workService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете изменять этот тег")
        }

        return workService.updateById(objectId, dto)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val objectId = ObjectId(id)

        if (!workService.isOwner(workService.getById(objectId), user._id)) {
            throw ForbiddenException("Вы не можете удалить это время")
        }

        return DeleteDto(workService.deleteById(objectId))
    }
}