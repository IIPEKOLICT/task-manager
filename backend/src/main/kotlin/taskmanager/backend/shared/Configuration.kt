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

    val databaseName: String
        get() = getStringParam("database.name")

    val bcryptStrength: Int
        get() = getStringParam("bcrypt.strength").toInt()

    val s3BucketName: String
        get() = getStringParam("s3.name")
}