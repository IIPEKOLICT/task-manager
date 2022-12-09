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
import taskmanager.backend.dtos.response.WorkResponseDto
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.mappers.WorkMapper
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.models.User
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.WorkService

@Controller("works")
class WorkController(
    private val workService: WorkService,
    private val workMapper: WorkMapper
) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(
        @JwtUser user: User,
        @Param("id") id: String
    ): WorkResponseDto {
        return workMapper.convert(
            userId = user._id,
            entity = workService.getById(ObjectId(id))
        )
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.WORK, "Вы не можете изменять это время")
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = WorkDto::class) dto: WorkDto
    ): WorkResponseDto {
        return workMapper.convert(
            userId = user._id,
            entity = workService.updateById(ObjectId(id), dto)
        )
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.WORK, "Вы не можете удалить это время")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        return DeleteDto(workService.deleteById(ObjectId(id)))
    }
}