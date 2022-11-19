package taskmanager.backend.plugins

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import org.koin.ktor.ext.inject
import taskmanager.backend.dtos.response.ExceptionResponseDto
import taskmanager.backend.services.UserService
import taskmanager.backend.shared.Configuration

fun Application.configureAuthorization() {
    val configuration by inject<Configuration>()
    val userService by inject<UserService>()

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

                    userService.getById(ObjectId(userId))
                    JWTPrincipal(credentials.payload)
                } catch (e: Exception) {
                    null
                }
            }

            challenge { defaultScheme, realm ->
                call.respond(
                    status = HttpStatusCode.Unauthorized,
                    message = ExceptionResponseDto(
                        code = HttpStatusCode.Unauthorized.value,
                        message = "Токен не валиден или его срок действия истек"
                    )
                )
            }
        }
    }
}