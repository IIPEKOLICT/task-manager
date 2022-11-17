package taskmanager.backend.injectors

import com.github.iipekolict.knest.injectors.PropertyInjector
import io.ktor.server.request.*
import org.koin.java.KoinJavaComponent
import taskmanager.backend.annotations.LocalUser
import taskmanager.backend.dtos.LoginDto
import taskmanager.backend.models.User
import taskmanager.backend.services.interfaces.IUserService
import kotlin.reflect.full.findAnnotation

class LocalUserInjector : PropertyInjector<LocalUser, User>() {

    private val userService by KoinJavaComponent.inject<IUserService>(IUserService::class.java)

    override fun findAnnotation(): LocalUser? {
        return parameter.findAnnotation()
    }

    override suspend fun inject(): User {
        val dto: LoginDto = call.receive()
        val user: User =  userService.getByEmailOrNull(dto.email) ?: throw RuntimeException()

        if (!user.comparePassword(dto.password)) {
            throw RuntimeException()
        }

        return user
    }
}