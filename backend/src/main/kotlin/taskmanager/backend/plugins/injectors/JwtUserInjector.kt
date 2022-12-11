package taskmanager.backend.plugins.injectors

import com.github.iipekolict.knest.injectors.PropertyInjector
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import org.bson.types.ObjectId
import org.koin.java.KoinJavaComponent
import taskmanager.backend.plugins.exceptions.custom.UnauthorizedException
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.models.User
import taskmanager.backend.services.UserService
import kotlin.reflect.full.findAnnotation

class JwtUserInjector : PropertyInjector<JwtUser, User>() {

    private val userService by KoinJavaComponent.inject<UserService>(UserService::class.java)

    override fun findAnnotation(): JwtUser? {
        return parameter.findAnnotation()
    }

    override suspend fun inject(): User {
        val principal: JWTPrincipal? = call.principal()

        return userService.getById(
            ObjectId(principal?.get("_id") ?: throw UnauthorizedException())
        )
    }
}