package taskmanager.backend.unit

import com.auth0.jwt.JWT
import com.auth0.jwt.JWTVerifier
import com.auth0.jwt.algorithms.Algorithm
import org.bson.types.ObjectId
import org.junit.Test
import org.koin.core.context.startKoin
import org.koin.core.context.stopKoin
import org.koin.test.KoinTest
import org.koin.test.get
import taskmanager.backend.services.AuthService
import taskmanager.backend.shared.Configuration
import taskmanager.backend.shared.Utils
import kotlin.test.assertEquals
import kotlin.test.assertNotNull

class AuthServiceTest : KoinTest {

    private val userId = ObjectId()
    private val email: String = "test@mail.ru"

    @Test
    fun `generateToken() should correctly generate token`() {
        startKoin {
            modules(Utils.koinTestModule)
        }

        val configuration: Configuration = get()
        val authService: AuthService = get()

        val token: String = authService.generateToken(userId, email)

        val jwtVerifier: JWTVerifier = JWT
            .require(Algorithm.HMAC256(configuration.jwtSecret))
            .withIssuer(configuration.jwtIssuer)
            .build()

        val tokenData = jwtVerifier.verify(token)

        assertNotNull(tokenData, "Token data shouldn't be empty")

        val tokenId = tokenData.claims["_id"]?.asString()
        val tokenEmail = tokenData.claims["email"]?.asString()

        assertNotNull(tokenId, "Token id shouldn't be empty")
        assertNotNull(tokenEmail, "Token email shouldn't be empty")

        assertEquals(userId.toString(), tokenId, "Id should match")
        assertEquals(email, tokenEmail, "Email should match")

        stopKoin()
    }
}