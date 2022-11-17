package taskmanager.backend.plugins

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.response.*
import org.koin.ktor.ext.inject
import taskmanager.backend.services.interfaces.IUserService
import taskmanager.backend.shared.Configuration

fun Application.configureAuthorization() {
    val configuration by inject<Configuration>()
    val userService by inject<IUserService>()

    authentication {
        jwt("auth-jwt") {
            verifier(
                JWT
                    .require(Algorithm.HMAC256(configuration.jwtSecret))
                    .withIssuer(configuration.jwtIssuer)
                    .build()
            )

            validate { credentials ->
                try {
                    val userId = credentials.payload.getClaim("_id")?.asString()
                        ?: throw RuntimeException()

                    userService.getById(userId)
                    JWTPrincipal(credentials.payload)
                } catch (e: Exception) {
                    null
                }
            }

            challenge { defaultScheme, realm ->
                call.respond(HttpStatusCode.Unauthorized, "Token is not valid or has expired")
            }
        }
    }
}