package taskmanager.backend.services

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import taskmanager.backend.services.interfaces.IAuthService
import taskmanager.backend.shared.Configuration
import java.time.Duration
import java.util.*

class AuthService(private val configuration: Configuration) : IAuthService {

    override fun generateToken(id: String, email: String): String {
        return JWT.create()
            .withIssuer(configuration.jwtIssuer)
            .withClaim("_id", id)
            .withClaim("email", email)
            .withExpiresAt(Date(System.currentTimeMillis() + Duration.ofDays(1).toMillis()))
            .sign(Algorithm.HMAC256(configuration.jwtSecret))
            ?: ""
    }
}