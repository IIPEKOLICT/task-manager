package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.Delete
import com.github.iipekolict.knest.annotations.methods.Get
import com.github.iipekolict.knest.annotations.methods.Patch
import com.github.iipekolict.knest.annotations.methods.Post
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.server.application.*
import io.ktor.server.response.*
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.dtos.CreateUserDto
import taskmanager.backend.dtos.DeleteDto
import taskmanager.backend.dtos.UpdateUserCredentialsDto
import taskmanager.backend.dtos.UpdateUserInfoDto
import taskmanager.backend.models.User
import taskmanager.backend.services.interfaces.IUserService

@Controller("users")
class UserController {

    private val userService by inject<IUserService>(IUserService::class.java)

    @Get
    suspend fun getAll(): List<User> {
        return userService.getAll()
    }

    @Get("{id}")
    suspend fun getById(@Param("id") id: String): User {
        return userService.getById(id)
    }

    @Post
    suspend fun create(@Body() dto: CreateUserDto): User {
        return userService.create(dto)
    }

    @Patch("{id}/credentials")
    suspend fun updateCredentials(@Param("id") id: String, @Body() dto: UpdateUserCredentialsDto): User {
        return userService.updateCredentials(id, dto)
    }

    @Patch("{id}/info")
    suspend fun updateInfo(@Param("id") id: String, @Body() dto: UpdateUserInfoDto): User {
        return userService.updateInfo(id, dto)
    }

    @Delete("{id}")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        return DeleteDto(userService.deleteById(id))
    }
}