package taskmanager.backend.shared

import io.ktor.server.config.*

class Configuration(private val appConfig: ApplicationConfig) {

    private fun getStringParam(path: String): String {
        return appConfig.property(path).getString()
    }

    val jwtSecret: String
        get() = getStringParam("jwt.secret")

    val jwtIssuer: String
        get() = getStringParam("jwt.issuer")

    val databaseUrl: String
        get() = getStringParam("database.url")

    val bcryptStrength: Int
        get() = getStringParam("bcrypt.strength").toInt()
}