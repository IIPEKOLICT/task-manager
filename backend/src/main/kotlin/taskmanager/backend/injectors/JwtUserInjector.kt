package taskmanager.backend.injectors

import com.github.iipekolict.knest.injectors.PropertyInjector
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import org.koin.java.KoinJavaComponent
import taskmanager.backend.annotations.JwtUser
import taskmanager.backend.models.User
import taskmanager.backend.services.interfaces.IUserService
import kotlin.reflect.full.findAnnotation

class JwtUserInjector : PropertyInjector<JwtUser, User>() {

    private val userService by KoinJavaComponent.inject<IUserService>(IUserService::class.java)

    override fun findAnnotation(): JwtUser? {
        return parameter.findAnnotation()
    }

    override suspend fun inject(): User {
        val principal: JWTPrincipal? = call.principal()
        return userService.getById(principal?.get("_id") ?: throw RuntimeException())
    }
}