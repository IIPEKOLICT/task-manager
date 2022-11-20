package taskmanager.backend.plugins.injectors

import com.github.iipekolict.knest.injectors.PropertyInjector
import io.ktor.server.request.*
import org.koin.java.KoinJavaComponent
import taskmanager.backend.plugins.annotations.LocalUser
import taskmanager.backend.dtos.request.LoginDto
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.exceptions.custom.UnauthorizedException
import taskmanager.backend.models.User
import taskmanager.backend.services.UserService
import kotlin.reflect.full.findAnnotation

class LocalUserInjector : PropertyInjector<LocalUser, User>() {

    private val userService by KoinJavaComponent.inject<UserService>(UserService::class.java)

    override fun findAnnotation(): LocalUser? {
        return parameter.findAnnotation()
    }

    override suspend fun inject(): User {
        val dto: LoginDto = call.receive()
        val user: User = userService.getByEmailOrNull(dto.email)
            ?: throw UnauthorizedException("Пользователь с таким E-mail не существует")

        if (!user.comparePassword(dto.password)) {
            throw ForbiddenException("Неверный пароль")
        }

        return user
    }
}