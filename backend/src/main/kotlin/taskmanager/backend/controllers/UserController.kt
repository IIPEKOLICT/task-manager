package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.File
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.dtos.request.CreateUserDto
import taskmanager.backend.dtos.request.DeleteDto
import taskmanager.backend.dtos.request.UpdateUserCredentialsDto
import taskmanager.backend.dtos.request.UpdateUserInfoDto
import taskmanager.backend.dtos.response.UserResponseDto
import taskmanager.backend.models.User
import taskmanager.backend.services.FileService
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.S3Service
import taskmanager.backend.services.UserService

@Controller("users")
class UserController(
    private val fileService: FileService,
    private val s3Service: S3Service,
    private val userService: UserService,
    private val projectService: ProjectService
) {

    @Get
    @Authentication(["auth-jwt"])
    suspend fun getAll(): List<UserResponseDto> {
        return userService.getAll().map { it.toResponseDto() }
    }

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): UserResponseDto {
        return userService.getById(ObjectId(id)).toResponseDto()
    }

    @Post
    @Authentication(["auth-jwt"])
    suspend fun create(@Body(type = CreateUserDto::class) dto: CreateUserDto): UserResponseDto {
        return userService.create(dto).toResponseDto()
    }

    @Patch("{id}/credentials")
    @Authentication(["auth-jwt"])
    suspend fun updateCredentials(
        @Param("id") id: String,
        @Body(type = UpdateUserCredentialsDto::class) dto: UpdateUserCredentialsDto
    ): UserResponseDto {
        return userService.updateCredentials(ObjectId(id), dto).toResponseDto()
    }

    @Patch("{id}/info")
    @Authentication(["auth-jwt"])
    suspend fun updateInfo(
        @Param("id") id: String,
        @Body(type = UpdateUserInfoDto::class) dto: UpdateUserInfoDto
    ): UserResponseDto {
        return userService.updateInfo(ObjectId(id), dto).toResponseDto()
    }

    @Patch("{id}/picture")
    @Authentication(["auth-jwt"])
    suspend fun updatePicture(
        @JwtUser user: User,
        @Param("id") id: String,
        @File("picture") picture: PartData.FileItem?
    ): UserResponseDto {
        if (picture == null) throw BadRequestException("Нет файла картинки")

        val picturePath = "/users/pictures/${user._id}.png"

        s3Service.save(
            path = picturePath,
            content = fileService.convertFileItemToByteArray(picture)
        )

        return userService.updatePicture(ObjectId(id), picturePath).toResponseDto()
    }

    @Delete("{id}/picture")
    @Authentication(["auth-jwt"])
    suspend fun deletePicture(
        @JwtUser user: User,
        @Param("id") id: String
    ): UserResponseDto {
        s3Service.delete("/users/pictures/${user._id}.png")
        return userService.updatePicture(ObjectId(id), null).toResponseDto()
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        val objectId = ObjectId(id)
        projectService.deleteByUser(objectId)
        return DeleteDto(userService.deleteById(objectId))
    }
}