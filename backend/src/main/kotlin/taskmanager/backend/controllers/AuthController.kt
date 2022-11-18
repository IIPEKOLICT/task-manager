package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.Authentication
import com.github.iipekolict.knest.annotations.methods.Post
import com.github.iipekolict.knest.annotations.properties.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.config.*
import io.ktor.server.response.*
import org.koin.java.KoinJavaComponent.inject
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.plugins.annotations.LocalUser
import taskmanager.backend.dtos.request.AuthDto
import taskmanager.backend.dtos.request.CreateUserDto
import taskmanager.backend.models.User
import taskmanager.backend.services.AuthService
import taskmanager.backend.services.UserService
import java.util.*

@Controller("auth")
class AuthController {

    private val authService by inject<AuthService>(AuthService::class.java)
    private val userService by inject<UserService>(UserService::class.java)

    @Post("refresh")
    @Authentication(["auth-jwt"])
    suspend fun refreshToken(@JwtUser user: User): AuthDto {
        return AuthDto(
            token = authService.generateToken(user._id.toString(), user.email),
            user = user.toResponseDto()
        )
    }

    @Post("register")
    suspend fun register(@Body(type = CreateUserDto::class) dto: CreateUserDto): AuthDto {
        val candidate: User? = userService.getByEmailOrNull(dto.email)

        if (candidate != null) {
            throw RuntimeException()
        }

        val user: User = userService.create(dto)

        return AuthDto(
            token = authService.generateToken(user._id.toString(), user.email),
            user = user.toResponseDto()
        )
    }

    @Post("login")
    suspend fun create(@LocalUser user: User): AuthDto {
        return AuthDto(
            token = authService.generateToken(user._id.toString(), user.email),
            user = user.toResponseDto()
        )
    }
}